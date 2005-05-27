Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <E73D9A5BC4A2D711BBC600065BF3595F1C66D087@il06exm10>
From: Mandalia Hiren-AHM047 <hirenm@motorola.com>
To: "'bluez-users@lists.sourceforge.net'" <bluez-users@lists.sourceforge.net>
Subject: RE: [Bluez-users] configure.in: 22: macro `AM_PATH_ALSA' not foun
	d in library
MIME-Version: 1.0
Content-Type: text/plain
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
Date: Fri, 27 May 2005 09:08:57 -0500

Hi Chombly,

I had this problem before and had found a way around that. This is what I posted then.


.... But I figured out what the problem was. The bootstrap script somehow did not check in the right directories for the alsa.m4 file that had the AM_PATH_ALSA macro. So I manually edited the script. I added the option with 'aclocal' like this

aclocal -I /usr/share/aclocal && ...

it compiled fine. I'm also able to use btsco (I tried aplay and it worked)

Regards,
Hiren

> -----Original Message-----
> From: bluez-users-admin@lists.sourceforge.net [mailto:bluez-users-
> admin@lists.sourceforge.net] On Behalf Of Brad Midgley
> Sent: Friday, May 27, 2005 8:47 AM
> To: bluez-users@lists.sourceforge.net
> Subject: Re: [Bluez-users] configure.in: 22: macro `AM_PATH_ALSA' not
> found in library
> 
> Hi
> 
> Make sure you have all the required libraries. libalsa-dev etc.
> 
> Brad
> 
> Alejandro Ferrer wrote:
> > Hi...
> >
> > I am new in Linux, I am trying to configure btsco, but when I try to
> > compile ./bootstrap I get the following message " configure.in: 22:
> macro
> > `AM_PATH_ALSA' not found in library"  and I dont know what can I do.
> >
> > If somebody can helpme with this I realy appreciate that.
> >
> > Thanks and Regards
> >
> > Chombly
> >
> >
> > -------------------------------------------------------
> > This SF.Net email is sponsored by Yahoo.
> > Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
> > Search APIs Find out how you can build Yahoo! directly into your own
> > Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-
> q22005
> > _______________________________________________
> > Bluez-users mailing list
> > Bluez-users@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-users
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by Yahoo.
> Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
> Search APIs Find out how you can build Yahoo! directly into your own
> Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
