Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: "Bearcat M. Sandor" <Linux@feline-soul.com>
To: bluez-users@lists.sourceforge.net
Date: Tue, 22 Aug 2006 00:37:19 -0600
References: <200608192203.34883.Linux@feline-soul.com>
	<44EA6D69.1090708@xmission.com>
	<200608212131.03574.Linux@feline-soul.com>
In-Reply-To: <200608212131.03574.Linux@feline-soul.com>
MIME-Version: 1.0
Message-Id: <200608220037.20159.Linux@feline-soul.com>
Subject: Re: [Bluez-users] Logitech Traveler Headset. Progress but not there
	yet. Advice wanted.
Reply-To: Linux@feline-soul.com,
        BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Ok, I am getting further. I have the snd_bt_sco module loaded.

Doing a btsco  00:0D:44:4F:37:72 gives me

Error: Failed to connect to SDP server: Function not implemented
Assuming channel 2

Can't connect RFCOMM channel: Resource temporarily unavailable

I'm a newbie at this bluetooth stuff. I'm not sure if i'm supposed to start 
the rfcomm program or what parameters i should send.

My config files are listed in the preceding emails.

Thank you for the help so far,

Bearcat M. Sandor
On Monday 21 August 2006 21:31 in an email titled "Re: [Bluez-users] Logitech 
Traveler Headset. Progress but not there yet. Advice wanted." Bearcat M. 
Sandor wrote:
>Brad,
>Thank you. That was immensely helpful. I have btsco installed.  I have
>followed the steps at the link you provided.
>I change to root user.
>
>After the "hciconfig hci0 voice 0x0060" is given my hciconfig looks like:
>hci0:   Type: USB
>        BD Address: 00:07:61:1C:9F:D3 ACL MTU: 192:8 SCO MTU: 64:8
>        UP RUNNING PSCAN
>        RX bytes:3908436 acl:279025 sco:0 events:1181 errors:0
>        TX bytes:1936 acl:16 sco:0 commands:192 errors:0
>        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
>        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>        Link policy: RSWITCH HOLD SNIFF PARK
>        Link mode: SLAVE ACCEPT
>        Name: 'BlueZ (0)'
>        Class: 0x3e0100
>        Service Classes: Networking, Rendering, Capturing, Object Transfer,
>Audio
>        Device Class: Computer, Uncategorized
>        HCI Ver: 1.1 (0x1) HCI Rev: 0x34e LMP Ver: 1.1 (0x1) LMP Subver:
> 0x34e Manufacturer: Cambridge Silicon Radio (10)
>
>Then i issue the "btsco 00:0D:44:4F:37:72" and i get:
>Error: hwdep next device (hw:0): Operation not permitted
>Error: hwdep next device (hw:1): Operation not permitted
>Error: control open (hw:2): No such device
>Error: Can't find device. Bail
>
>Bearcat M. Sandor
>
>
>
>On Monday 21 August 2006 20:35 in an email titled "Re: [Bluez-users]
> Logitech Traveler Headset. Progress but not there yet. Advice wanted." Brad
> Midgley
>
>wrote:
>>Bearcat
>>
>>> on button to get it to start paring. Then i issue a "hidd --connect
>>> 00:0D:44:4F:37:72" After awhile the headset stops blinking and "Can't get
>>> device information: Function not implemented" is returned for the
>>> hidd --connect.
>>
>>hidd is for connecting the keyboard/mouse/etc but not the headset. Check
>>with the docs at bluetooth-alsa.sf.net.
>>
>>Brad
>>
>>
>>-------------------------------------------------------------------------
>>Using Tomcat but need to do more? Need to support web services, security?
>>Get stuff done quickly with pre-integrated technology to make your job
>> easier Download IBM WebSphere Application Server v.1.0.1 based on Apache
>> Geronimo
>> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
>> _______________________________________________
>>Bluez-users mailing list
>>Bluez-users@lists.sourceforge.net
>>https://lists.sourceforge.net/lists/listinfo/bluez-users

-- 
Bearcat M. Sandor
Bearcat@feline-soul.com
Jabber: bearcat@jabber.feline-soul.net
ICQ: 6628727
MSN: bearcatsandor@hotmail.com
Yahoo: bearcatsandor
AIM: bearcatmsandor



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
