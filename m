Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Jouni.Lohikoski@iki.fi" <jlohikos@cc.hut.fi>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] bluez-hciemu-1.0 install error- Glib Not found
Message-ID: <20040929155222.GA131327@kosh.hut.fi>
Reply-To: Jouni.Lohikoski@iki.fi
References: <296459384.12087@bjut.edu.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <296459384.12087@bjut.edu.cn>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 29 Sep 2004 18:52:22 +0300

On Wed, Sep 29, 2004 at 08:15:46PM +0800, Jin Pu wrote:
>  checking for glib-config... not found
>  configure: error: GLib not found
>  ---then ./configure exit back to the shell---
>  
>  I know from the README, I need GLib package before
>  install the hciemu. But I suppose that the package is
>  already installed with RedHat 9.

You need glib-devel package in RH9 or in Fedora. When developing
something, you need many devel-packages.

After error like this, you could try if you find yourself the missing
file/program. One method here:

# locate glib-config
.....probably won't find it.

Then to < http://rpm.pbone.net/ >
and "Search for rpms which contain given file name": "glib-config"

...you can guess from the results, you'll need glib-devel package.

// jouni



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
