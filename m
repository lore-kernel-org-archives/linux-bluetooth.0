Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Tue, 7 Aug 2007 17:25:08 +0200 (CEST)
From: Guennadi Liakhovetski <gl@dsa-ac.de>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.63.0708071702431.8578@pcgl.dsa-ac.de>
Message-ID: <Pine.LNX.4.63.0708071721480.8578@pcgl.dsa-ac.de>
References: <Pine.LNX.4.63.0708071702431.8578@pcgl.dsa-ac.de>
MIME-Version: 1.0
Subject: Re: [Bluez-users] [REGRESSION] last working kernel 2.6.18
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

On Tue, 7 Aug 2007, Guennadi Liakhovetski wrote:

> Doing "hcitool cc" under 2.6.18 establishes a connection and keeps it 
> open, which can be confirmed per "hcitool cc". Under 2.6.20 and 2.6.22 a 
> connection gets established, but is immediately (within 1-2 seconds) 
> broken. Is it a change in interfaces, is one supposed to connect 

Just looked with hcidump, and it looks like it just sends the disconnect 
request now... Here's the dump from 2.6.18:

1186499898.489550 < HCI Command: Create Connection (0x01|0x0005) plen 13
1186499898.496035 > HCI Event: Command Status (0x0f) plen 4
1186499901.854045 > HCI Event: Connect Complete (0x03) plen 11
1186499901.854072 < HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
1186499901.864062 > HCI Event: Command Status (0x0f) plen 4
1186499901.869054 > HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
1186499901.874058 > HCI Event: Max Slots Change (0x1b) plen 3
1186499901.904065 > HCI Event: Command Status (0x0f) plen 4
1186499901.904086 < HCI Command: Write Link Policy Settings (0x02|0x000d) plen 41186499901.914055 > HCI Event: Command Complete (0x0e) plen 6
1186499901.914073 < HCI Command: Remote Name Request (0x01|0x0019) plen 10
1186499901.924061 > HCI Event: Command Status (0x0f) plen 4
1186499901.929055 > HCI Event: Read Remote Supported Features (0x0b) plen 11
1186499901.998030 > HCI Event: Remote Name Req Complete (0x07) plen 255

and under 2.6.22:

1186499587.139648 < HCI Command: Create Connection (0x01|0x0005) plen 13
1186499587.148291 > HCI Event: Command Status (0x0f) plen 4
1186499590.061422 > HCI Event: Connect Complete (0x03) plen 11
1186499590.061513 < HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
1186499590.069417 > HCI Event: Command Status (0x0f) plen 4
1186499590.071418 > HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
1186499590.074423 > HCI Event: Max Slots Change (0x1b) plen 3
1186499590.107440 > HCI Event: Command Status (0x0f) plen 4
1186499590.107522 < HCI Command: Write Link Policy Settings (0x02|0x000d) plen 41186499590.114417 > HCI Event: Command Complete (0x0e) plen 6
1186499590.114497 < HCI Command: Remote Name Request (0x01|0x0019) plen 10
1186499590.120445 > HCI Event: Command Status (0x0f) plen 4
1186499590.127424 > HCI Event: Read Remote Supported Features (0x0b) plen 11
1186499590.164446 > HCI Event: Remote Name Req Complete (0x07) plen 255
1186499592.059386 < HCI Command: Disconnect (0x01|0x0006) plen 3
1186499592.063548 > HCI Event: Command Status (0x0f) plen 4
1186499592.091548 > HCI Event: Disconn Complete (0x05) plen 4

So, the only questions that remain are "why", and "how do I keep the 
connection"?

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
