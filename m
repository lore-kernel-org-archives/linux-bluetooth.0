Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Gareth Reakes <gareth@apache.org>
To: "Michal Semler (volny.cz)" <cijoml@volny.cz>
Cc: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] MS Wireless keyboard scans remapping
In-Reply-To: <200310280847.39317.cijoml@volny.cz>
Message-ID: <20031028023707.H69922@minotaur.apache.org>
References: <200310280847.39317.cijoml@volny.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 28 Oct 2003 02:39:09 -0800 (PST)

Hi,
	I made a patch for the keyboard to work with UK key bindings. I
cant get to it until tonight, but it should help you. It defintely fixes
the ! character.

Gareth

On Tue, 28 Oct 2003, Michal Semler (volny.cz) wrote:

> Hi,
>
> my keyboard works now fine, but I found keys which doesn't. Looks like MS
> changed scan codes for them.
>
> How can I get these events from keys and put them unto hid.c of bthid package?
> Keys which doesn't works are:
>
> Stand by
> Functionkey F
> windows key opens properties
> colona key |
> other key in german version marked like criminal key #
>
> Thanks very much for hinting, coz colona is one of the most used key in Linux
> :))
>
> Michal
>
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: The SF.net Donation Program.
> Do you like what SourceForge.net is doing for the Open
> Source Community?  Make a contribution, and help us add new
> features and functionality. Click here: http://sourceforge.net/donate/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>


-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
