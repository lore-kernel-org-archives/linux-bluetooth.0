Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <5f84803c0710170748j57f46eebh37a6707b9ec02b86@mail.gmail.com>
Date: Wed, 17 Oct 2007 10:48:08 -0400
From: "Chris Rivera" <chrismrivera@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1192631052.6184.25.camel@violet>
MIME-Version: 1.0
References: <5f84803c0710161138i6123770dk22c1b63d03f45f59@mail.gmail.com>
	<1192631052.6184.25.camel@violet>
Subject: Re: [Bluez-devel] [PATCH] make bluez GNOME UIs singletons
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0400078098=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0400078098==
Content-Type: multipart/alternative;
	boundary="----=_Part_72767_8919811.1192632488713"

------=_Part_72767_8919811.1192632488713
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 10/17/07, Marcel Holtmann <marcel@holtmann.org> wrote:

>
> actually the wizard and the properties applications are meant to be
> _not_ singletons. They are designed in a way that multiple instances can
> exist and work together.
>
> For the applet, only one instance is useful. However for testing and
> development purposes it is nice to start two of them.
>

The applet already has the ability to launch the properties dialog and I
think it should also have an entry to launch the wizard.   This makes it
very easy to get to a state where you have multiple copies open at once.  I
think it's confusing to users and it doesn't buy you anything.  Just in case
it's not clear, the patch allows for one instance per desktop session.

Chris

------=_Part_72767_8919811.1192632488713
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<span class="gmail_quote">On 10/17/07, <b class="gmail_sendername">Marcel Holtmann</b> &lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt; wrote:</span><br><div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br>actually the wizard and the properties applications are meant to be<br>_not_ singletons. They are designed in a way that multiple instances can<br>exist and work together.<br><br>For the applet, only one instance is useful. However for testing and
<br>development purposes it is nice to start two of them.<br></blockquote></div><br>The applet already has the ability to launch the properties dialog and I think it should also have an entry to launch the wizard.&nbsp;&nbsp; This makes it very easy to get to a state where you have multiple copies open at once.&nbsp; I think it&#39;s confusing to users and it doesn&#39;t buy you anything.&nbsp; Just in case it&#39;s not clear, the patch allows for one instance per desktop session.
<br><br>Chris<br>

------=_Part_72767_8919811.1192632488713--


--===============0400078098==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--===============0400078098==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0400078098==--
