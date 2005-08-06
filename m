Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: John Gruenenfelder <johng@as.arizona.edu>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Problem with link keys
Message-ID: <20050806050145.GA11152@as.arizona.edu>
References: <20050806030119.GA10008@as.arizona.edu> <1123301455.26693.4.camel@pegasus>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="vtzGhvizbBRQ85DL"
In-Reply-To: <1123301455.26693.4.camel@pegasus>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 5 Aug 2005 22:01:45 -0700


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 06, 2005 at 06:10:55AM +0200, Marcel Holtmann wrote:
>> 
>> I do not see any "reply negative" messages in any of the hcidump output yet it
>> doesn't work until I make a new key.
>
>use "hcidump -X -V".

The -V helps a lot.  I have attached a short hcidump listing from when I power
on the headset and it attempts to make a connection and fails.

>> Am I doing something wrong or in the wrong order?  This is with the current
>> bluez packages from Debian unstable (amd64 port).
>
>Is the link key valid if you don't power cycle your headset, but
>disconnect and then reconnect? If yes, then your headset is maybe
>broken.

Yes.  I was able to do the following:

hcitool cc bdaddr
hcitool dc bdaddr
hcitool cc bdaddr
hcitool info bdaddr

And it is working just fine.  It only seems to misbehave when I power it off.
Are any other people on this list using a Plantronics M2500 headset and, if
so, are you experiencing anything similar?


-- 
--John Gruenenfelder    Research Assistant, Steward Observatory, U of Arizona
                        johng@as.arizona.edu
Try Weasel Reader for PalmOS  --  http://gutenpalm.sf.net
"This is the most fun I've had without being drenched in the blood
of my enemies!"
        --Sam of Sam & Max

--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="connect_attempt.log"

HCI sniffer - Bluetooth packet analyzer ver 1.23
device: hci0 snap_len: 1028 filter: 0xffffffffffffffff
> HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:03:89:6E:C9:11 class 0x20040c type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 00:03:89:6E:C9:11 role 0x00
    Role: Master
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:03:89:6E:C9:11
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 00:03:89:6E:C9:11 key EB66D91F1F03B1531043A4E00E5F0199
> HCI Event: Role Change (0x12) plen 8
    status 0x00 bdaddr 00:03:89:6E:C9:11 role 0x00
    Role: Master
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 00:03:89:6E:C9:11
> HCI Event: Connect Complete (0x03) plen 11
    status 0x05 handle 41 bdaddr 00:03:89:6E:C9:11 type ACL encrypt 0x00
    Error: Authentication Failure
> HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:03:89:6E:C9:11 class 0x20040c type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 00:03:89:6E:C9:11 role 0x00
    Role: Master
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:03:89:6E:C9:11
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 00:03:89:6E:C9:11 key EB66D91F1F03B1531043A4E00E5F0199
> HCI Event: Role Change (0x12) plen 8
    status 0x00 bdaddr 00:03:89:6E:C9:11 role 0x00
    Role: Master
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 00:03:89:6E:C9:11
> HCI Event: Connect Complete (0x03) plen 11
    status 0x05 handle 42 bdaddr 00:03:89:6E:C9:11 type ACL encrypt 0x00
    Error: Authentication Failure
> HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:03:89:6E:C9:11 class 0x20040c type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 00:03:89:6E:C9:11 role 0x00
    Role: Master
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:03:89:6E:C9:11
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 00:03:89:6E:C9:11 key EB66D91F1F03B1531043A4E00E5F0199
> HCI Event: Role Change (0x12) plen 8
    status 0x00 bdaddr 00:03:89:6E:C9:11 role 0x00
    Role: Master
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 00:03:89:6E:C9:11
> HCI Event: Connect Complete (0x03) plen 11
    status 0x05 handle 43 bdaddr 00:03:89:6E:C9:11 type ACL encrypt 0x00
    Error: Authentication Failure
> HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:03:89:6E:C9:11 class 0x20040c type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 00:03:89:6E:C9:11 role 0x00
    Role: Master
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:03:89:6E:C9:11
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 00:03:89:6E:C9:11 key EB66D91F1F03B1531043A4E00E5F0199
> HCI Event: Role Change (0x12) plen 8
    status 0x00 bdaddr 00:03:89:6E:C9:11 role 0x00
    Role: Master
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 00:03:89:6E:C9:11
> HCI Event: Connect Complete (0x03) plen 11
    status 0x05 handle 44 bdaddr 00:03:89:6E:C9:11 type ACL encrypt 0x00
    Error: Authentication Failure

--vtzGhvizbBRQ85DL--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
