Return-Path: <djrobx@hotmail.com>
From: "Rob Raper" <djrobx@hotmail.com>
To: marcel@holtmann.org
Cc: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] What's the best way to go about device detection?
Date: Sun, 16 May 2004 10:42:10 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY14-F3781Np7vXee40004099a@hotmail.com>
List-ID: <bluez-users.lists.sourceforge.net>

Hi Marcel.  Thanks for your reply.   I'll have a look into RSSI.   Is it 
possible to use RSSI for detection, but then use RFCOMM to do the actual 
communications?    Once "linked" to a server they don't ever need to talk to 
multiple servers at the same time.  It's just that other servers need to 
determine signal strength in order to decide when to perform a hand off.

Here's the block of code that I'm currently using to do a scan.  The old 
version which worked better was simply a verison of the "hcitool scan" 
routine modified to connect and check singal strength.

the MobileOrbiterSocket class is my list of known BT devices that I could 
potentially connect to.

Thanks again for your help, it's much appreciated!


	int dev_id;
	dev_id = hci_devid(GetData()->Get_MAC_ADDR().c_str());
	if (dev_id < 0)
	{
		dev_id = hci_get_route(NULL);
		if (dev_id < 0)
		{
			m_pOCLogger->Write(LV_CRITICAL, "Can't get an ID for bluetooth dongle.");
			return;
		}
		else
		{
			m_pOCLogger->Write(LV_WARNING,"Bluetooth dongle %s not found, using 
hci0.", GetData()->Get_MAC_ADDR().c_str());
		}
	}

	int m_fdHCI = hci_open_dev(dev_id);
	if (m_fdHCI < 0)
	{
		m_pOCLogger->Write(LV_CRITICAL,"Device open failed");
		return;
	}
	OCSafetyFD sfhci(&m_fdHCI);
	m_DevInfo.dev_id = dev_id;
	if (ioctl(m_fdHCI, HCIGETDEVINFO, (void*) &m_DevInfo))
	{
		m_pOCLogger->Write(LV_CRITICAL,"Can't get info about device");
		return;
	}
	ba2str(&m_DevInfo.bdaddr, addr);
	m_pOCLogger->Write(LV_STATUS,"Attached to BT adapter: %s\t%s\n", 
m_DevInfo.name, addr);

	struct hci_filter nf;
	hci_filter_clear(&nf);
	hci_filter_all_ptypes(&nf);
	hci_filter_all_events(&nf);
	if (setsockopt(m_fdHCI, SOL_HCI, HCI_FILTER, &nf, sizeof(nf)))
	{
		m_pOCLogger->Write(LV_CRITICAL,"Failed to set filter: %s\n", 
strerror(errno));
		return;
	}

	map<string, MobileOrbiterSocket *>::iterator iMos;
	unsigned char buf[HCI_MAX_EVENT_SIZE], *ptr;
	evt_cmd_complete *cc;
	evt_cmd_status   *cs;
	evt_conn_complete *ecc;
	evt_disconn_complete *dcc;
	get_link_quality_rp *rp;
	hci_event_hdr *hdr;

	while(!m_bQuit)
	{
		struct timeval tv;
		int res;
		fd_set fds;
		tv.tv_sec = 1;
		tv.tv_usec = 0;
		for (;;) {
			FD_ZERO(&fds);
			FD_SET(m_fdHCI, &fds);
			res = select(m_fdHCI + 1, &fds, NULL, NULL, &tv);
			if (!res)
				break;
			if (res < 0) {
				if ((errno == EAGAIN) || (errno == EINTR))
					continue;
				break;
			}
			if (FD_ISSET(m_fdHCI, &fds))
			{
				while((res = read(m_fdHCI, buf, sizeof(buf))) < 0)
				{
					if ((errno == EAGAIN) || (errno == EINTR))
						continue;
				}
				printf("Read...\n");
				if (res < 0)
				{
					m_pOCLogger->Write(LV_STATUS, "Error reading from HCI handle");
				}
				else
				{
					hdr = (hci_event_hdr *)(buf + 1);
					ptr = buf + (1 + HCI_EVENT_HDR_SIZE);
					res -= (1 + HCI_EVENT_HDR_SIZE);
					switch(hdr->evt) {
					case EVT_CMD_STATUS:
						cs = (evt_cmd_status *)ptr;
						switch(cs->opcode) {
						case SETUP_OPCODE:
							/* Setup */
							printf("Got %d bytes of setup status, status is %x!\n", res, 
cs->status);
							if (cs->status == 0x0c)  // Busy.
							{
								m_bIsSettingUp = false;
							}
							break;
						default:
							m_pOCLogger->Write(LV_CRITICAL, "Got status %02x on unknown opcode 
%d/%d, length %d\n", cs->status, cs->opcode, cs->ncmd, res);
						}
						break;
					case EVT_CONN_COMPLETE:
						m_bIsSettingUp = false;
						ecc = (evt_conn_complete *)ptr;
						ba2str(&ecc->bdaddr, addr);
						if (!ecc->status)
						{
							printf("Connected failed to '%s', status is %d\n", addr, 
ecc->status);
							break;
						}
						else
						{
							iMos = m_OrbiterSockets.find(addr);
							if (iMos != m_OrbiterSockets.end())
							{
								printf("Got connected to '%s'\n", addr);
								(*iMos).second->SetState(MOS_LINKED);
								(*iMos).second->m_ctNextEventTime = 
time(NULL)+MOS_T_CONNECT_STRENGTH_DELAY;
								(*iMos).second->m_Handle = ecc->handle;
							}
						}
						break;
					case EVT_DISCONN_COMPLETE:
						dcc = (evt_disconn_complete *)ptr;
						for(iMos = m_OrbiterSockets.begin(); iMos != m_OrbiterSockets.end(); 
++iMos)
						{
							if ((*iMos).second->m_Handle == dcc->handle)
							{
								switch((*iMos).second->GetState())
								{
									case MOS_CONNECTED:
										(*iMos).second->Disconnect();
										break;
									case MOS_LINKED:
										(*iMos).second->SetState(MOS_IDLE);
										(*iMos).second->m_ctNextEventTime = 
time(NULL)+MOS_T_TRYCONNECT_INTERVAL;
										break;
									default:
										printf("Notice (benign): Got disconnect for %s in state %d", 
(*iMos).first.c_str(), (*iMos).second->GetState());
										break;
								}
							}
						}
						break;
					case EVT_CMD_COMPLETE:
						cc = (evt_cmd_complete *)ptr;
						switch(cc->opcode) {
						case LQ_OPCODE:
							/* Link Quality Reply */
							rp = (get_link_quality_rp *)(ptr + EVT_CMD_COMPLETE_SIZE);
							for(iMos = m_OrbiterSockets.begin(); iMos != m_OrbiterSockets.end(); 
++iMos)
							{
								if ((*iMos).second->m_Handle == rp->handle)
								{
									switch((*iMos).second->GetState())
									{
										case MOS_LINKED_LINEQUALITY:
											if (!rp->status)
											{
												int diff = (*iMos).second->m_SignalStrength - rp->link_quality;
												if (diff < -15 || diff > 15)
												{
													printf("Detection event, link quality: %d", rp->link_quality);
													GetEvents()->Mobile_Orbiter_Detected(addr, 
StringUtils::itos(rp->link_quality).c_str());
													(*iMos).second->m_SignalStrength=rp->link_quality;
												}
											}
											else
											{
												m_pOCLogger->Write(LV_STATUS, "Notice (benign): Got status %d on 
link quality!", rp->status);
											}
											(*iMos).second->SetState(MOS_LINKED);
											(*iMos).second->m_ctNextEventTime = 
time(NULL)+MOS_T_SIGNALSTRENGTH_INTERVAL;
											break;
										case MOS_CONNECTED_LINEQUALITY:
											if (!rp->status)
											{
												(*iMos).second->m_SignalStrength=rp->link_quality;
											}
											else
											{
												m_pOCLogger->Write(LV_STATUS, "Notice (benign): Got status %d on 
link quality!", rp->status);
											}
											(*iMos).second->SetState(MOS_CONNECTED);
											break;
									}
								}
							}
							break;
						case SETUP_OPCODE:
							/* Setup */
							printf("Got %d bytes of setup complete!\n", res);
							break;
						default:
							m_pOCLogger->Write(LV_CRITICAL, "Got complete on unknown opcode 
%d/%d, length %d\n", cc->opcode, cc->ncmd, res);
						}
						break;
					case EVT_QOS_SETUP_COMPLETE:
						/* Ignore */
						break;
					default:
						printf("Got unknown event '%02x' with %d bytes\n", hdr->evt, res);
					}
				}
			}
		}








>From: Marcel Holtmann <marcel@holtmann.org>
>To: Rob Raper <djrobx@hotmail.com>
>CC: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
>Subject: Re: [Bluez-users] What's the best way to go about device 
>detection?
>Date: Sun, 16 May 2004 14:23:59 +0200
>
>Hi Rob,
>
> > Sorry for the newbie questions or if I'm missing some obvious concepts, 
>but
> > I can't find any documentation for bluez, I've been primarily hacking
> > samples and learning by experimentation.  My RFCOMM implementation from 
>a
> > single server to a single phone works perfectly, my problem has to do 
>with
> > detection of a bluetooth device and signal strengths.
> >
> > I'm writing an application that involves having cell phones that
> > automatically attach to servers when they come into range; like a 
>'roaming'
> > application.    When the phone gets closer to another server (when going
> > from room to room), the previous server should detach from it and the 
>next
> > server will attach.  These servers are connected in their own way over
> > ethernet and coordinate the hand-off.
> >
> > So, the server needs to look for available phones and report their 
>signal
> > strengths, even if they're connected to another server.   When one
> > connection becomes significantly stronger, it will perform a coordinated
> > hand off (coordated by ethernet, not bluetooth).
>
>without knowing the source code it is hard to say, but actually I think
>this is a Bluetooth topology problem. Looks like that you are builing
>complex scatternets and the master/slave roles and the role switch are
>going to hit you badly.
>
>You should start using RSSI for signal strength, because link quality is
>a vendor specific value and differ from Bluetooth chip manufacturer to
>the other. The other big advantage with RSSI is that with Bluetooth 1.2
>you get it for free from an inquiry.
>
>Regards
>
>Marcel
>
>
>
>
>-------------------------------------------------------
>This SF.Net email is sponsored by: SourceForge.net Broadband
>Sign-up now for SourceForge Broadband and get the fastest
>6.0/768 connection for only $19.95/mo for the first 3 months!
>http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
>_______________________________________________
>Bluez-users mailing list
>Bluez-users@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-users

_________________________________________________________________
Stop worrying about overloading your inbox - get MSN Hotmail Extra Storage! 
http://join.msn.click-url.com/go/onm00200362ave/direct/01/
