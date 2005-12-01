Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Remote name delay
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb0512011117i730f7dd0p4ffc099d06a09cb8@mail.gmail.com>
References: <e1effdeb0512011117i730f7dd0p4ffc099d06a09cb8@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1133470780.18554.2.camel@blade>
Mime-Version: 1.0
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
Date: Thu, 01 Dec 2005 21:59:40 +0100

Hi Claudio,

> I am developing a standalone application to perform real D-Bus
> services tests. The main features are:
> 1. Running all the time in the systray
> 2. Handle PIN Request
> 3. Local adapter configuration
> 4. Basic operations: Inquiry, Remote name, ...

cool idea. We really need something like this.

> However I am facing a problem in the RemoteName service when a lot of
> inquiry replies is received. My app stores the inquired devices in a
> hash table and when the InquiryCompleted signal is received the app
> request the name for each device. The "hci_send_req" function is
> returning an Input/Output error. Looking the hcidump result, the
> "Command Disallowed" error is displayed :(
> 
> HCIDUMP:
> > HCI Event: Command Status (0x0f) plen 4
>     Remote Name Request (0x01|0x0019) status 0x0c ncmd 1
>     Error: Command Disallowed
>  <<<<<Indicates that the controller is in a state where it can process
> this command at this time.>>>>
> 
> I noticed the same problem using the hcitool with "--flush" option and
> removing the cached device information stored in the directory
> "/var/lib/bluetooth".

What kind of chip is in your dongle? Do you wait until the remote name
complete event before asking for the next name? Every name request needs
at least a partial baseband connection.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
