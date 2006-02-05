Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43E673FD.8040005@in.tum.de>
From: Aleksandar Kanchev <kanchev@in.tum.de>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] broadcast packets
References: <BAY24-F20084DBFE3577D788A970CF82F0@phx.gbl>	 <1136420779.6652.30.camel@localhost> <dpotfk$832$1@sea.gmane.org>	 <43C1356C.60109@in.tum.de>  <43C4C236.5060100@in.tum.de> <1136968575.26114.8.camel@localhost.localdomain>
In-Reply-To: <1136968575.26114.8.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 05 Feb 2006 22:54:05 +0100

Hi Marcel,

I was away for a while :) But here's what I'm trying to do:
I'm using 2 laptops with 2 Belkin class 2 USB bluetooth dongles. Both 
laptops are running linux with bluez.
I want to broadcast packets from the one side to the other. To do that 
I'm connection both laptops with the hcitool and then from the master 
side I'm using the following code:
  int dd, i, ret = -1, hci_dev;
  u_short handle, flags;

  char buf[HCI_ACL_HDR_SIZE + L2CAP_SIZE];
  hci_acl_hdr *acl_hdr = (hci_acl_hdr *) buf;
  l2cap_hdr *l2hdr = (l2cap_hdr *) (buf + HCI_ACL_HDR_SIZE);
  uint16_t *psm = (uint16_t *) (((char *) l2hdr) + L2CAP_HDR_SIZE);
  char *l2cap_data = ((char *) psm) + sizeof(uint16_t);

  struct iovec iv[2];
  uint8_t type = HCI_ACLDATA_PKT;

  hci_dev = hci_get_route(NULL);
  dd = hci_open_dev(hci_dev);

  handle = 1;
  flags |= ACL_START;
  flags |= ACL_ACTIVE_BCAST;
  acl_hdr->handle = htobs(acl_handle_pack(handle, flags));
  acl_hdr->dlen = htobs(L2CAP_SIZE);

  l2hdr->len = htobs(sizeof(uint16_t) + L2CAP_DATA_SIZE);
  l2hdr->cid = htobs(0x0002);
  *psm = htobs(4097);

  for (i = 0; i < L2CAP_DATA_SIZE; i++)
    l2cap_data[i] = 'A';

  iv[0].iov_base = &type;
  iv[0].iov_len = 1;
  iv[1].iov_base = buf;
  iv[1].iov_len = sizeof(buf);
  writev(dd, iv, 2);

I can see the packet being transmitted on the local master side (with 
hcidump) but the other end doesn't seem to see it. At least hcidump is 
not dumping the packet.

Thanks

Marcel Holtmann wrote:

>Hi Aleksandar,
>
>  
>
>>Marcel, could you please answer me that ? :)
>>    
>>
>
>I already told you everything I know and I have no idea why you still
>stick to the broadcast thing. Once you have established the piconet
>between two devices, you can use it to transfer data. Doing everything
>on HCI level is not a good idea. Use at least the L2CAP level for it,
>but you might need to add some kernel code to make it work properly. The
>broadcast stuff is not really used in any Bluetooth application so far.
>
>Regards
>
>Marcel
>
>
>
>
>-------------------------------------------------------
>This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
>for problems?  Stop!  Download the new AJAX search engine that makes
>searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
>http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
>_______________________________________________
>Bluez-users mailing list
>Bluez-users@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>  
>



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
