Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-Id: <IAM5FF$26988C38C1B7C74AE27C3AE78F151AF6@libero.it>
Subject: Re: [Bluez-users] Piconet problems
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
From: "jers@inwind.it" <jers@inwind.it>
To: "bluez-users" <bluez-users@lists.sourceforge.net>
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
Date: Thu, 20 Jan 2005 12:33:15 +0100

Hi Marcel, 
 
I thank you for your time but, I'm sorry,  I can't displa=
y any packet. 
 
I changed my dongles. Their firmware is HCI 16.14: =0D
=
 
hci0:   Type: USB 
        BD Address: 00:08:E0:01:9E:86 ACL MTU: 192=
:8 SCO MTU: 64:8 
        UP RUNNING PSCAN ISCAN 
        RX bytes:2508=
 acl:0 sco:0 events:60 errors:0 
        TX bytes:465 acl:0 sco:0 comman=
ds:47 errors:0 
        Features: 0xff 0xff 0x0b 0x00 0x00 0x00 0x00 0x0=
0 
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
        Li=
nk policy: RSWITCH HOLD SNIFF PARK 
        Link mode: SLAVE ACCEPT 
  =
      Name: 'pcB' 
        Class: 0x000000 
        Service Classes: Un=
specified 
        Device Class: Miscellaneous, 
        HCI Ver: 1.1 (=
0x1) HCI Rev: 0x33c LMP Ver: 1.1 (0x1) LMP Subver: 0x33c 
        Manufa=
cturer: Cambridge Silicon Radio (10) 
 
I installed linux again (Mandra=
ke 9.1, kernel 2.4.21) and the upgrated BlueZ packages in accordance with=
 readme 
files of each packages. I tried to create a simple connection. =

 
On the master side, I run: 
 
modprobe bnep 
modprobe l2cap 
hci=
config hci0 up 
pand --listen --role GN 
 
On the slave side, I run; =0D
=
 
modprobe bnep 
modprobe l2cap 
hciconfig hci0 up 
pand -c <master_a=
ddr> 
 
At first, "hcidump -x" dispayed packets sent by the pand comman=
d. Trying several times, it showed L2CAP and in 
only one case I showed =
BNEP. However, no connection was create. 
Then, maybe after a reboot or =
a logout, hcidump shows again that pand does not send any packet,. 
I ca=
n't obtain again the same situation and I don't realize why. 
 
I hope =
can help me. 
Thanks. Jers 
 
 
 
> Hi Jers, 
>  
> > > > > Run "h=
cidump -x" as root and show us the output.   
> > > >    
> > > > HCIDu=
mp - HCI packet analyzer ver 1.16   
> > > > device: hci0 snap_len: 1028=
 filter: 0xffffffff   
> > >   
> > > What about trying to connect now,=
 so we see traffic?  
> >    
> > Running 'pan -c <addr>' or 'pan --lis=
ten --rule GN',  HCIDump does not show anything.  
>  
> you will see t=
raffic, because otherwise you do something wrong. 
>  
> Regards 
>  =0D
=
> Marcel 
>  
>  
>  
>  
> ----------------------------------------=
--------------- 
> The SF.Net email is sponsored by: Beat the post-holid=
ay blues 
> Get a FREE limited edition SourceForge.net t-shirt from Thin=
kGeek. 
> It's fun and FREE -- well, almost....http://www.thinkgeek.com/=
sfshirt 
> _______________________________________________ 
> Bluez-use=
rs mailing list 
> Bluez-users@lists.sourceforge.net 
> https://lists.s=
ourceforge.net/lists/listinfo/bluez-users 
>  =0A=0A=0A=0A______________=
______________________________________________=0A6X velocizzare la tua na=
vigazione a 56k? 6X Web Accelerator di Libero!=0AScaricalo su INTERNET GR=
ATIS 6X http://www.libero.it=0A



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
