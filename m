Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <b8950797050112073133375ee9@mail.gmail.com>
From: Weston Weems <wweems@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] replicate hcitool scan using bluez libs
In-Reply-To: <1105532304.7961.58.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <b8950797050111232241c3de8b@mail.gmail.com>
	 <1105532304.7961.58.camel@pegasus>
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
Date: Wed, 12 Jan 2005 07:31:25 -0800

Sounds good to me, I'll go read up in the source, an I think I should
be able to pick it up rather easily. Thank you.


On Wed, 12 Jan 2005 13:18:24 +0100, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Weston,
> 
> > I am a little new to the bluez libs etc, and am trying to essentiall
> > call functions in the bluez libs to simulate "scan" behaviour of
> > hcitool.
> >
> > At first I thought it was inquiry in hci.h but after running the
> > tools, seems like they yeild different results. Also, device_id is id
> > of the bluetooth radio in the system?
> 
> the "scan" combines the hci_inquiry() with hci_read_remote_name() and
> thats it. The source is in hcitool.c at cmd_scan(). And dev_id is the
> number of your local HCI device (see "hcitool dev").
> 
> Regards
> 
> Marcel
> 
> -------------------------------------------------------
> The SF.Net email is sponsored by: Beat the post-holiday blues
> Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
> It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
