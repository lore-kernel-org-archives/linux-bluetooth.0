Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <5f84803c0710251622g64559cai7e09e657f9c78665@mail.gmail.com>
Date: Thu, 25 Oct 2007 19:22:23 -0400
From: "Chris Rivera" <chrismrivera@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1193352257.6184.282.camel@violet>
MIME-Version: 1.0
References: <5f84803c0710251220m73a0b7va39bd0c46cfaabd9@mail.gmail.com>
	<1193352257.6184.282.camel@violet>
Subject: Re: [Bluez-devel] [PATCH] Add an ellipsis to the preferences menu
	item
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2100366093=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============2100366093==
Content-Type: multipart/alternative;
	boundary="----=_Part_3525_14952325.1193354544340"

------=_Part_3525_14952325.1193354544340
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Agreed.  We need to follow the HIG.  According to:

http://developer.gnome.org/projects/gup/hig/hig-diff/menus-design.html

the ellipsis should be in place only if it _requires_ further input from the
user.  I guess the ellipsis isn't necessary.

Chris

On 10/25/07, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Chris,
>
> > Since the Preferences menu entry in the applet opens a new window it
> > should probably have an ellipsis in the label.  Attached is a trivial
> > patch to add this.
>
> what does the HIG recommend for applet menus. I wanna follow the HIG.
> Currently I simply did what all other applets do that I have running.
>
> Regards
>
> Marcel
>
>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc.
> Still grepping through log files to find problems?  Stop.
> Now Search log events and configuration files using AJAX and a browser.
> Download your FREE copy of Splunk now >> http://get.splunk.com/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

------=_Part_3525_14952325.1193354544340
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Agreed.&nbsp; We need to follow the HIG.&nbsp; According to:<br><br><a href="http://developer.gnome.org/projects/gup/hig/hig-diff/menus-design.html">http://developer.gnome.org/projects/gup/hig/hig-diff/menus-design.html</a><br><br>the ellipsis should be in place only if it _requires_ further input from the user.&nbsp; I guess the ellipsis isn&#39;t necessary.
<br><br>Chris<br><br><div><span class="gmail_quote">On 10/25/07, <b class="gmail_sendername">Marcel Holtmann</b> &lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi Chris,<br><br>&gt; Since the Preferences menu entry in the applet opens a new window it<br>&gt; should probably have an ellipsis in the label.&nbsp;&nbsp;Attached is a trivial<br>&gt; patch to add this.<br><br>what does the HIG recommend for applet menus. I wanna follow the HIG.
<br>Currently I simply did what all other applets do that I have running.<br><br>Regards<br><br>Marcel<br><br><br><br>-------------------------------------------------------------------------<br>This SF.net email is sponsored by: Splunk Inc.
<br>Still grepping through log files to find problems?&nbsp;&nbsp;Stop.<br>Now Search log events and configuration files using AJAX and a browser.<br>Download your FREE copy of Splunk now &gt;&gt; <a href="http://get.splunk.com/">http://get.splunk.com/
</a><br>_______________________________________________<br>Bluez-devel mailing list<br><a href="mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-devel">
https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br></blockquote></div><br>

------=_Part_3525_14952325.1193354544340--


--===============2100366093==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--===============2100366093==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============2100366093==--
