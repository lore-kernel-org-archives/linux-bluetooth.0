Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Jonathan Sass <jsass@magnifeye.com>
Subject: Re: [Bluez-users] Permissions on Sockets
In-reply-to: <1106092579.8190.81.camel@pegasus>
To: bluez-users@lists.sourceforge.net
Message-id: <6DD9FBCE-69DB-11D9-A39A-000D9348D4BE@magnifeye.com>
MIME-version: 1.0
Content-type: text/plain; charset=US-ASCII; format=flowed
References: <41B8A67C.3060608@paytec.com> <1102627652.7962.4.camel@pegasus>
 <8EEDF252-6988-11D9-A39A-000D9348D4BE@magnifeye.com>
 <1106092579.8190.81.camel@pegasus>
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
Date: Tue, 18 Jan 2005 21:31:54 -0800

Thank you for your help.

I am doing an inquiry of all devices, finding our device, connecting to 
it and the reading bytes via a rawsocket.

The only issue I see so far is the writev command (I copied the code 
from hci_send_cmd).

How do I assign root rights for this?

On Jan 18, 2005, at 3:56 PM, Marcel Holtmann wrote:

> Hi Jonathan,
>
>> My application connects to a custom device.  The app works when I run
>> as su but I get an error from hci_send_cmd from the writev(dd, iv, 
>> ivn)
>> when I run as a regular user.
>>
>> Are there some permissions that I need to set to allow my regular user
>> to write to the socket?
>
> for some HCI commands you need root rights. About what commands are we
> talking?
>



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
