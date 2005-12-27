Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20051227081143.53072.qmail@web36104.mail.mud.yahoo.com>
From: Swathi Mathur80 <swathi_mathur80@yahoo.com>
Subject: Fwd PLS HELP ME: Re: [Bluez-users] Can't connect RFCOMM channel: Resource temporarily unavailable
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1440874192-1135671103=:50507"
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
Date: Tue, 27 Dec 2005 00:11:43 -0800 (PST)

--0-1440874192-1135671103=:50507
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Hello Everyone and Marcel,
Pls someone help me in fixing this problem and getting
my headset pairing. Really i need to fix this problem
within a week or else i loose the project.
Pls pls somebody help me
Warm Regards,
Swathi

Note: forwarded message attached.



		
__________________________________________ 
Yahoo! DSL – Something to write home about. 
Just $16.99/mo. or less. 
dsl.yahoo.com 

--0-1440874192-1135671103=:50507
Content-Type: message/rfc822
Content-Transfer-Encoding: 8bit

Received: from [155.69.5.235] by web36112.mail.mud.yahoo.com via HTTP; Thu, 22 Dec 2005 01:28:04 PST
Date: Thu, 22 Dec 2005 01:28:03 -0800 (PST)
From: Swathi Mathur80 <swathi_mathur80@yahoo.com>
Subject: Re: [Bluez-users] Can't connect RFCOMM channel: Resource temporarily unavailable
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1135163495.26233.58.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Length: 2572

Hello Marcel,
As per your request i have pasted the result of
“hciconfig -a” and “hcidump -X -V”. Along with it
someother information which i thought might be helpful
in debugging.

When i first started my pc if found that hcid demon
was not running. So i re-started the bluetooth
services and made the hcid to run
-------------------------------------------------------
[root@localhost bluetooth]# /etc/init.d/bluetooth
status
hcid is stopped
sdpd (pid 1729) is running...
[root@localhost bluetooth]# /etc/init.d/bluetooth
restart
Stopping Bluetooth services:                          
    [FAILED]
Starting Bluetooth services:                          
    [  OK  ]
[root@localhost bluetooth]# /etc/init.d/bluetooth
restart
Stopping Bluetooth services:                          
    [  OK  ]
Starting Bluetooth services:                          
    [  OK  ]
-------------------------------------------------------

The headset is being put in the pairing mode. Hcidump
-X -V is running in the background. I execute the
btsco command
-------------------------------------------------------
[root@localhost /]# btsco 00:08:C6:3E:54:2C -v -r
btsco v0.4c
Device is 1:0
Error: Failed to connect to SDP server: Function not
implemented
Assuming channel 2

Voice setting: 0x0060
Can't connect RFCOMM channel: Resource temporarily
unavailable
-------------------------------------------------------

output of hcidump -X -V is as below
-------------------------------------------------------
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:08:C6:3E:54:2C ptype 0xcc18 rswitch 0x01
clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: PIN Code Request (0x16) plen 6
    bdaddr 00:08:C6:3E:54:2C
> HCI Event: Connect Complete (0x03) plen 11
    status 0x22 handle 41 bdaddr 00:08:C6:3E:54:2C
type ACL encrypt 0x00
    Error: LMP Response Timeout
< HCI Command: Read Voice Setting (0x03|0x0025) plen 0
> HCI Event: Command Complete (0x0e) plen 6
    Read Voice Setting (0x03|0x0025) ncmd 1
    status 0x00 voice setting 0x0060
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:08:C6:3E:54:2C ptype 0xcc18 rswitch 0x01
clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: PIN Code Request (0x16) plen 6
    bdaddr 00:08:C6:3E:54:2C
> HCI Event: Connect Complete (0x03) plen 11
    status 0x22 handle 42 bdaddr 00:08:C6:3E:54:2C
type ACL encrypt 0x00
    Error: LMP Response Timeout
-------------------------------------------------------
The output of “hciconfig -a” is as below
-------------------------------------------------------
[root@localhost bluetooth]# hciconfig -a
hci0:   Type: USB
        BD Address: 00:10:60:A5:A7:61 ACL MTU: 192:8
SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:181 acl:0 sco:0 events:23 errors:0
        TX bytes:94 acl:0 sco:0 commands:18 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00
0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2
HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'localhost.localdomain-0'
        Class: 0x000000
        Service Classes: Unspecified
        Device Class: Miscellaneous,
        HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1
(0x1) LMP Subver: 0x20d
        Manufacturer: Cambridge Silicon Radio (10)
-------------------------------------------------------

Output of /etc/init.d/bluetooth status
-------------------------------------------------------
[root@localhost mail]# /etc/init.d/bluetooth status
hcid (pid 3136) is running...
sdpd (pid 3140) is running...
-------------------------------------------------------
output of “ps x”
 2714 ?        Ss     0:00 hcid: processing events
 2716 ?        Ss     0:00 sdpd
-------------------------------------------------------
I got 
You have new mail in /var/spool/mail/root after
executing “btsco xxxx“ command and i have enclosed the
mail. I don’t know whether i will be helpful in
debugging. Basically what i noticed was 2 things one
saying

 --------------------- Connections (secure-log) Begin
-----------------
 **Unmatched Entries**
 userhelper[3460]: running
'/usr/share/hwbrowser/hwbrowser' with root privileges
on behalf of 'root'
 userhelper[3599]: running
'/usr/share/hwbrowser/hwbrowser' with root privileges
on behalf of 'root'
---------------------- Connections (secure-log) End
--------------------

 --------------------- SSHD Begin
------------------------
 SSHD Killed: 6 Time(s)
 SSHD Started: 6 Time(s)
 Failed to bind:
    0.0.0.0 port 22 (Address already in use) : 6
Time(s)
 ---------------------- SSHD End
-------------------------

My apologies for such a long  mail. 
Warm Regards,
Swathi










--- Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Swathi,
> 
> > I have installed all the bluez-packages and bt_sco
> > module as a root. All the commands which are
> trying to
> > establish a connection to my headset are being
> > executed as a root. I login with root privilages
> and
> > at this point if 
> > 
> > i check the status of hcid it was showing as
> stopped.
> > (below output)
> >
>
------------------------------------------------------
> > [root@localhost /]# /etc/init.d/bluetooth status
> > hcid is stopped
> > sdpd (pid 1725) is running...
> >
>
------------------------------------------------------
> > 
> > So i restarted the bluetooth and for the first
> time i
> > got the below msg
> >
>
------------------------------------------------------
> > [root@localhost /]# /etc/init.d/bluetooth restart
> > Stopping Bluetooth services:                      
>    
> >     [FAILED]
> > Starting Bluetooth services:                      
>    
> >     [  OK  ]
> >
>
------------------------------------------------------
> > 
> > For the second time, i was able to successfully
> stop
> > and start BT services
> >
>
------------------------------------------------------
> > [root@localhost /]# /etc/init.d/bluetooth restart
> > Stopping Bluetooth services:                      
>    
> >     [  OK  ]
> > Starting Bluetooth services:                      
>    
> >     [  OK  ]
> >
>
------------------------------------------------------
> > 
> > cross checking the BT status again
> >
>
------------------------------------------------------
> > [root@localhost /]# /etc/init.d/bluetooth status
> > hcid (pid 2743) is running...
> > sdpd (pid 2745) is running...
> >
>
------------------------------------------------------
> 
> check this with "ps x" as root. I don't trust it,
> because the hcidump
> output is telling me something different. Show me
> also the output of
> "hciconfig -a".
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
> This SF.net email is sponsored by: Splunk Inc. Do
> you grep through log files
> for problems?  Stop!  Download the new AJAX search
> engine that makes
> searching your log files as easy as surfing the 
> web.  DOWNLOAD SPLUNK!
>
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
>
https://lists.sourceforge.net/lists/listinfo/bluez-users
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

--0-1440874192-1135671103=:50507--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
