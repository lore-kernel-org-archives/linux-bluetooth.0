Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050319123711.14688.qmail@web60901.mail.yahoo.com>
From: Ka Kin Cheung <michaelhku2002@yahoo.com.hk>
Subject: Re: [Bluez-users] Re: adding sdp service record attributes
To: bluez-users@lists.sourceforge.net
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
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
Date: Sat, 19 Mar 2005 20:37:11 +0800 (CST)

Hi Marcel!
    I've set the SDP service profile and the
attributes for headset and set the class of my
computer to headset. Then my T610 can search my Linux
PC as headset. However, when I pressed "connect" item,
the phone tried to connect to the PC, but then the
phone showed "Bluetooth connection failed". Is there
any thing that I need to set in my PC, or how to
modify my sdp program so that the phone can connect to
PC?
    My steps are as follows:
1.run my sdp program to add service and set the
attributes.
2.change the class of my PC to be the one of headset.
3.let T610 to search my PC and then connect to PC.
    Is there anything wrong here?
    Thank you very much.
Michael

--- Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Andreas,
> 
> > > 1.Is there any extra thing I have to put so that
> the
> > > service record and attributes are set in my PC
> > > permanently and not being erased after reboot?
> > 
> > Small shell script ?
> 
> there is no shell script needed, because if you
> wanna run a server then
> you need to write a program (and start it) that
> fulfils this job. The
> same program can create the SDP record when it
> starts.
> 
> > > 2.After I add the service record and attribute,
> I wish
> > > to let T610 to search my PC as headset. So, is
> there
> > > any extra thing that I have to put in my code?
> > 
> > I guess you has to change your device class of
> your BT-device to phone. Please 
> > have a look into the hcid config file.
> 
> You must set yourself to the headset class of device
> (0x200404).
> 
> > > 3.Is it possible that to browse the services in
> T610,
> > > and even other mobile devices, and then add the
> > > service records and attributes automatically?
> > 
> > Where? In our own SDP database? What would you
> like to reach with those?
> 
> No it is not possible and it also makes no sense at
> all.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
>
-------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT
> Products from real users.
> Discover which products truly live up to the hype.
> Start reading now.
>
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
>
https://lists.sourceforge.net/lists/listinfo/bluez-users
> 

_______________________________________________________________________
Yahoo! 工具列 - 內置防止彈出視窗工能！
http://toolbar.yahoo.com.hk


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
