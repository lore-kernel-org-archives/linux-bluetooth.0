Return-Path: <cyrus@holtmann.org>
From: Gene Heskett <gene.heskett@verizon.net>
To: jayjwa <jayjwa@atr2.ath.cx>, linux-bluetooth@vger.kernel.org
Subject: Re: The link I had working quit.  Help
Date: Mon, 06 Apr 2009 14:57:02 -0400
References: <200904041636.25409.gene.heskett@verizon.net>
 <200904051759.31968.gene.heskett@verizon.net>
 <alpine.LNX.2.00.0904060246560.29837@nge2.ngu.pk>
In-reply-to: <alpine.LNX.2.00.0904060246560.29837@nge2.ngu.pk>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Message-id: <200904061457.02511.gene.heskett@verizon.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Monday 06 April 2009, jayjwa wrote:
>On Sun, 5 Apr 2009, Gene Heskett wrote:
>> Been playing with a script, step by step.  It gets to the line
>> hciconfig -a hci0 putkey 0000 (which is the default key at the other end
>> of this link I'm trying to reliably establish)
>
>Read your other mail; looks like you got it going. Possibly they need to
>re-pair? Sometimes clearing /var/lib/bluetooth/*  will help, or wherever
>bluetooth link key info is stored on your system. Sometimes it gets stale.
>
>Another idea is try to re-pair the devices. Are you running the
> passkey-agent and auth-agent?

What are those?  I never heard of them before.  I just built and installed 
bluez-4.34

>> The script:
>> ----------------------------------
>> #!/bin/bash
>> echo attempting to get bt link to the coco3
>> echo "rfcomm release hci0"
>> rfcomm release hci0
>
>This is strange that it works; the "release" refers to the rfcomm minor
>number, not the hci device number. It should be "rfcomm release 0", refering
>to rfcomm0.

It didn't.

I have bluez-4.34 installed on top of the rpm of 4.30.  I saw that mistake, 
and it said all according to the manpage, but I've set that to 0 now.

>> sleep 5
>> echo "hciconfig hci0 down"
>> hciconfig -a hci0 down
>> sleep 5
>> echo "hciconfig -a hci0 up"
>> hciconfig -a hci0 up
>> sleep 5
>
>I've never used the up and down commands. That should happen automatically.

Ok, I'll nuke those from the test script.

So that script now:

#!/bin/bash
echo attempting to get bt link to the coco3
echo "rfcomm release 0"
rfcomm release 0
sleep 2
ls -l /dev/rfcomm*
sleep 2
rfcomm -i 11:11:11:11:11:11 show hci0
sleep 2
echo "resetting hci0"
hciconfig reset hsi0
sleep 2
ls -l /dev/rfcomm*
sleep 2
rfcomm -i 11:11:11:11:11:11 show hci0
sleep 2
ls -l /dev/rfcomm*
sleep 2
echo "hciconfig -a"
hciconfig -a
sleep 2
ls -l /dev/rfcomm*
sleep 2
echo "rfcomm -i 11:11:11:11:11:11 bind hci0 00:0c:84:00:86:F8"
rfcomm -i 11:11:11:11:11:11 bind hci0 00:0c:84:00:86:F8
sleep 2
ls -l /dev/rfcomm*
sleep 2
echo "rfcomm connect 0 00:0c:84:00:86:F8 1"
rfcomm connect 0 00:0c:84:00:86:F8 1
echo this should show the cocos address
rfcomm -i 11:11:11:11:11:11 show 0


And the shell output is:
[root@coyote bin]# ./connect2coco3                        
attempting to get bt link to the coco3                    
rfcomm release 0 
ls: cannot access /dev/rfcomm*: No such file or directory 
Get info failed: No such device
resetting hci0
hci0:   Type: USB                                         
        BD Address: 11:11:11:11:11:11 ACL MTU: 672:3 SCO MTU: 48:1
        UP RUNNING PSCAN ISCAN                                    
        RX bytes:15003 acl:10 sco:0 events:440 errors:0<-note RX count, events         
        TX bytes:4548 acl:10 sco:0 commands:403 errors:0<-TX will increase

ls: cannot access /dev/rfcomm*: No such file or directory
Get info failed: No such device                          
ls: cannot access /dev/rfcomm*: No such file or directory
hciconfig -a                                             
hci0:   Type: USB                                        
        BD Address: 11:11:11:11:11:11 ACL MTU: 672:3 SCO MTU: 48:1
        UP RUNNING PSCAN ISCAN                                    
        RX bytes:15003 acl:10 sco:0 events:440 errors:0  <-note RX byte count
        TX bytes:4548 acl:10 sco:0 commands:403 errors:0          
        Features: 0xff 0x3e 0x85 0x38 0x18 0x18 0x00 0x00         
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3          
        Link policy: RSWITCH HOLD SNIFF PARK                      
        Link mode: SLAVE ACCEPT                                   
        Name: 'coyote.coyote.den-0'                               
        Class: 0x4a2104                                           
        Service Classes: Networking, Capturing, Telephony         
        Device Class: Computer, Desktop workstation               
        HCI Ver: 2.0 (0x3) HCI Rev: 0x1f4 LMP Ver: 2.0 (0x3) LMP Subver: 0x1f4
        Manufacturer: CONWISE Technology Corporation Ltd (66)                 

ls: cannot access /dev/rfcomm*: No such file or directory
rfcomm -i 11:11:11:11:11:11 bind 0 00:0c:84:00:86:F8     
crw------- 1 root root 216, 0 2009-04-06 14:11 /dev/rfcomm0
rfcomm connect 0 00:0c:84:00:86:F8 1                       
Can't connect RFCOMM socket: Host is down                  
this should show the cocos address                         
rfcomm0: 11:11:11:11:11:11 -> 00:0C:84:00:86:F8 channel 1 clean 

[root@coyote bin]# cat /dev/rfcomm0  (gets nothing)
^C                                 

[root@coyote bin]# hciconfig -a
hci0:   Type: USB              
        BD Address: 11:11:11:11:11:11 ACL MTU: 672:3 SCO MTU: 48:1
        UP RUNNING PSCAN ISCAN                                    
        RX bytes:15671 acl:12 sco:0 events:456 errors:0 <-note byte count        
        TX bytes:4643 acl:12 sco:0 commands:411 errors:0          
        Features: 0xff 0x3e 0x85 0x38 0x18 0x18 0x00 0x00         
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3          
        Link policy: RSWITCH HOLD SNIFF PARK                      
        Link mode: SLAVE ACCEPT                                   
        Name: 'coyote.coyote.den-0'                               
        Class: 0x4a2104                                           
        Service Classes: Networking, Capturing, Telephony         
        Device Class: Computer, Desktop workstation               
        HCI Ver: 2.0 (0x3) HCI Rev: 0x1f4 LMP Ver: 2.0 (0x3) LMP Subver: 0x1f4
        Manufacturer: CONWISE Technology Corporation Ltd (66)                 

[root@coyote bin]# hciconfig -a
hci0:   Type: USB              
        BD Address: 11:11:11:11:11:11 ACL MTU: 672:3 SCO MTU: 48:1
        UP RUNNING PSCAN ISCAN                                    
        RX bytes:15948 acl:12 sco:0 events:459 errors:0 <- increasing counts           
        TX bytes:4652 acl:12 sco:0 commands:414 errors:0 <-same for TX          
        Features: 0xff 0x3e 0x85 0x38 0x18 0x18 0x00 0x00         
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3          
        Link policy: RSWITCH HOLD SNIFF PARK                      
        Link mode: SLAVE ACCEPT                                   
        Name: 'coyote.coyote.den-0'                               
        Class: 0x4a2104                                           
        Service Classes: Networking, Capturing, Telephony         
        Device Class: Computer, Desktop workstation               
        HCI Ver: 2.0 (0x3) HCI Rev: 0x1f4 LMP Ver: 2.0 (0x3) LMP Subver: 0x1f4
        Manufacturer: CONWISE Technology Corporation Ltd (66)                 

[root@coyote bin]# hciconfig -a
hci0:   Type: USB
        BD Address: 11:11:11:11:11:11 ACL MTU: 672:3 SCO MTU: 48:1
        UP RUNNING PSCAN ISCAN
        RX bytes:16225 acl:12 sco:0 events:462 errors:0 <-increased RX, events
        TX bytes:4661 acl:12 sco:0 commands:417 errors:0
        Features: 0xff 0x3e 0x85 0x38 0x18 0x18 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'coyote.coyote.den-0'
        Class: 0x4a2104
        Service Classes: Networking, Capturing, Telephony
        Device Class: Computer, Desktop workstation
        HCI Ver: 2.0 (0x3) HCI Rev: 0x1f4 LMP Ver: 2.0 (0x3) LMP Subver: 0x1f4
        Manufacturer: CONWISE Technology Corporation Ltd (66)

[root@coyote bin]# hciconfig -a
hci0:   Type: USB
        BD Address: 11:11:11:11:11:11 ACL MTU: 672:3 SCO MTU: 48:1
        UP RUNNING PSCAN ISCAN
        RX bytes:16502 acl:12 sco:0 events:465 errors:0 <-RX, events up
        TX bytes:4670 acl:12 sco:0 commands:420 errors:0
        Features: 0xff 0x3e 0x85 0x38 0x18 0x18 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'coyote.coyote.den-0'
        Class: 0x4a2104
        Service Classes: Networking, Capturing, Telephony
        Device Class: Computer, Desktop workstation
        HCI Ver: 2.0 (0x3) HCI Rev: 0x1f4 LMP Ver: 2.0 (0x3) LMP Subver: 0x1f4
        Manufacturer: CONWISE Technology Corporation Ltd (66)

[root@coyote bin]#

So traffic is indeed flowing!  But where to?

The device on the other end is sending a continuous string of
Coco3 at coyote.den
at about 3x/second

And it has an led that when connected, will blink on and off at 2 second 
intervals, but is not.  When it worked, it did blick correctly.

So traffic IS flowing, I just can't get the device to show it to me,  or get 
picocom or minicom to even find /dev/rfcomm0

[root@coyote bin]# cat /dev/rfcomm0
cat: /dev/rfcomm0: Host is down
[root@coyote bin]# minicom
minicom: cannot open /dev/rfcomm0: Host is down

Your comment about 
>Another idea is try to re-pair the devices. Are you running the
> passkey-agent and auth-agent?

Is another clue, but neither of those exist on this system.  What package are 
they part of?

I do have the bluetooth-wizard, which on its device display screen shows blank 
space where the device list should be.

bluetooth-analyzer shows a blank device list
bluetooth-sendto can select a file ok, but the next, send to device screen is 
also blank.

>> echo "hciconfig -a hci0 putkey 0000"
>> hciconfig -a hci0 putkey 0000
>> --------which returns:
>> Can't find link key for 0000 on hci0
>> ^C
>
>I've never used the command, but by its help screen you're using it wrong.
>That would refer to the bt device 0000, which isn't even a valid address
>format:
>
>putkey     <bdaddr>     Store link key on the device

Ok, understood, but where does it get the link key to 'putkey' then?>
The current version of the script doesn't have this command anymore.

>My advice would be not to manually attempt to handle the link key, but let
> the passkey-agent/auth-agent/whatever do it itself. Assuming blues-3.x
> here.
Now have 4.34

>> And as you can see I killed it there.  What am I doing wrong?
>> -------------script continues----------------
>> sleep 5
>> echo "rfcomm -i 11:11:11:11:11:11 bind hci0 00:0c:84:00:86:F8"
>> rfcomm -i 11:11:11:11:11:11 bind hci0 00:0c:84:00:86:F8
>
>This worked with no channel named? Then again, I don't know if one is really
>needed. Uncharted waters I'm heading into here...

Acc. the manpage, channel is optional, uses channel 1 if not given.>

>> sleep 5
>> echo "rfcomm -i 11:11:11:11:11:11 connect hci0 00:0c:84:00:86:F8"
>> rfcomm -i 11:11:11:11:11:11 connect hci0 00:0c:84:00:86:F8
>
>If you have only one local device, you don't need to tell it which one to
> use with -i, since there's only one choice to select anyway. So it could
> be:
>
>rfcomm connect 0 00:0c:84:00:86:F8 <channel>

I had a 'watch' running, stopped that: then
[root@coyote sysconfig]# rfcomm  show rfcomm0
rfcomm0: 11:11:11:11:11:11 -> 00:0C:84:00:86:F8 channel 1 closed
rfcomm connect 0 00:0c:84:00:86:F8  (a good 10 sec delay here)
Can't connect RFCOMM socket: Connection timed out

>
>Again, not sure about leaving off the channel part.
>
>> sleep 5
>> echo this should show the cocos address
>> rfcomm -i 11:11:11:11:11:11 show hci0
>> -------------------------------
>> And it did yesterday morning before I broke it somehow trying to make a
>> script that Just Worked(TM) :(
>
>I'd try to start fresh, with a re-pairing.
>
>> Where are the bluetooth guru's?  Or, where can I find the RFC documents
>> that describe how all this is supposed to work?
>
>If they're on the bt list, then they are silent. They never answer me there;
> I asked about getting bt headsets going under 4.x, and only one person
> remarked he thought he saw kernel messages. I'm assuming then that no-one
> uses headsets under 4.x. From the other questions on the list, no-one uses
> anything successfully under 4.x, unless you count /usr/bin/patch. Really
> I'm thinking of unsubscribing.

It doesn't seem to be all that helpful, you and I believe one other person has 
replied, always by personal email rather than the list.  That is not what 
keeping an archive of a list is all about. BTW, where is that list archive?

>> What I want to  do, and was doing, is to run a system shell on the bt
>> device on the other end, and minicom or picocom  to /dev/rfcomm0 as a
>> remote terminal on that system.
>
>When you get it going good, write the Howto. I'd like to read it ;)

Chuckle, So would I, like to read it that is! :)

/etc/init.d/bluetooth is also running.  kernel is 2.6.29.1-rc2 with all bt 
related stuffs enabled. lsmod |grep rfcomm returns:
[root@coyote bin]# lsmod|grep rfcomm
rfcomm                 35644  5
l2cap                  21260  16 rfcomm,bnep
bluetooth              52228  27 rfcomm,sco,bnep,l2cap,btusb

I went to google and looked up 'bluetoogh pairing' and got this:
http://www.bluetomorrow.com/content/section/180/284/
but no real howto.  And I did chase down quite a few other links, mostly for 
pairing with mobile phones or headsets, nothing on using them as a wireless 
rs232 circuit.  Which is what I want of course.

One more hciconfig -a after all that typing time:
hci0:   Type: USB
        BD Address: 11:11:11:11:11:11 ACL MTU: 672:3 SCO MTU: 48:1
        UP RUNNING PSCAN ISCAN
        RX bytes:17371 acl:12 sco:0 events:478 errors:0
        TX bytes:4729 acl:12 sco:0 commands:431 errors:0
        Features: 0xff 0x3e 0x85 0x38 0x18 0x18 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'coyote.coyote.den-0'
        Class: 0x4a2104
        Service Classes: Networking, Capturing, Telephony
        Device Class: Computer, Desktop workstation
        HCI Ver: 2.0 (0x3) HCI Rev: 0x1f4 LMP Ver: 2.0 (0x3) LMP Subver: 0x1f4
        Manufacturer: CONWISE Technology Corporation Ltd (66)

Thank you jayjwa, and I appreciate very much your use of english as its the 
only language this old (74) fart knows.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
My computer, my documents, my briefcase, my ASS!

   -- Ben Cook

