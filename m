Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <41F53A2B.5020200@eridani.co.uk>
From: Michael McConnell <mike@eridani.co.uk>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Bluez BNEP connection close
References: <6.1.2.0.2.20050124165802.04168330@luna.tlmat.unican.es>	 <1106581771.8058.49.camel@pegasus>	 <6.1.2.0.2.20050124172931.041a03a0@pop.gmx.net> <1106583831.8058.52.camel@pegasus>
In-Reply-To: <1106583831.8058.52.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Mon, 24 Jan 2005 18:10:51 +0000

Marcel Holtmann wrote:
> Hi George,
> 
> 
>>The fact is that I have copy pand code to automate them into my 
>>application. My application makes a bridge in order to communicate WIFI and 
>>BlueTooth.
>>
>>The traffic is not too much.. when I run a ping -s 50000 it crashes and 
>>hangs. The result is that some packets are transmitted correctly while 
>>others doesn't.
>>The bnep0 connection disappears and then both ends are no more connected.
>>
>>After happening all that things I have to restart everything as the sdpd 
>>and also the bluetooth devices on both ends are hanged.
>>
>>For giving more information, one of the ends is a Sharp Zaurus 5500 and the 
>>other is a Laptop using and AnyCom usb dongle
>>
>>By having a look at /var/log/messages I have one messge that is:
>>
>>Kernel: NETDED WATCHDOG: bnep0: transmit timed out
>>
>>and also in other parts
>>
>>Jan 24 17:14:35 kernel: hci_acl_tx_to: hci0 ACL tx timeout
>>Jan 24 17:14:35 kernel: hci_acl_tx_to: hci0 killing stalled ACL connection 
>>BA:D4:09:EE:02:00
>>Jan 24 17:14:35 kernel: hci_acl_tx_to: hci0 ACL tx timeout
>>Jan 24 17:14:35 kernel: hci_acl_tx_to: hci0 killing stalled ACL connection 
>>BA:D4:09:EE:02:00
> 
> 
> I actually expected to see this kind of messages. Seems like you should
> replace the hardware. What does "hciconfig hci0 version" say about your
> Bluetooth adapters?
> 
> Regards
> 
> Marcel

I'm also seeing these issues - and it trips up when I transmit a bit of data 
(amount variable :( )  including (but seemingly not limited to) SSH, VNC, FTP 
and Samba.

-- 
-- Michael McConnell
Eridani MailStripper - www.eridani.co.uk/MailStripper - SMTP-layer spam filter


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
