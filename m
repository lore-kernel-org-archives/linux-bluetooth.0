Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Nicholas A. Preyss" <nalp@gmx.net>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Thinkpad X31 @ fedora core 2, trying to connect to Nokia 6380i
Message-ID: <20040610101649.GA7496@gmx.net>
References: <m365a0b8f9.fsf@bfnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <m365a0b8f9.fsf@bfnet.com>
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
Date: Thu, 10 Jun 2004 12:16:49 +0200

On  0, David Wuertele <dave-gnus@bfnet.com> wrote:
> I boot my thinkpad, and the bluetooth chip is recognized.  My phone
> has bluetooth turned on.  I see my phone when I scan, but I can't seem
> to connect with it:
> 
> # uname -a
> Linux 5nave 2.6.5-1.358 #1 Sat May 8 09:04:50 EDT 2004 i686 i686 i386 GNU/Linux
> # rpm -q bluez-utils bluez-libs
> bluez-utils-2.4-3
> bluez-libs-2.5-2.1
> # hcitool scan
> Scanning ...
> 	00:60:57:2A:37:E9	Dave's Nokia
> [...]
> # ps auxwf | grep hcid
> root      1982  0.0  0.0  3100  700 ?        S    16:24   0:00 hcid: processing events
> root      2785  0.0  0.0  3104  700 ?        S    16:43   0:00  \_ hcid: processing events
> root      2790  0.0  0.0  4012  572 pts/1    S    16:44   0:00              \_ grep hcid
> # rfcomm connect rfcomm0 00:60:57:2A:37:E9
> Can't connect RFCOMM socket: Resource temporarily unavailable
> # tail -2 /var/log/messages
> Jun  9 16:43:37 5nave hcid[1982]: link_key_request (sba=00:20:E0:75:D6:F6, dba=00:60:57:2A:37:E9) 
> Jun  9 16:43:37 5nave hcid[1982]: pin_code_request (sba=00:20:E0:75:D6:F6, dba=00:60:57:2A:37:E9) 
> 
> Is there something else I should be doing?

Seems that your PIN exchange doesn't work. What is your "security"
setting in hcid.conf? Does appear a pin windows on the mobile display?

nicholas


-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
