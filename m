Return-Path: <cyrus@holtmann.org>
Message-ID: <de4879e80803260952t9967c01pbfe54c5d186419b6@mail.gmail.com>
Date: Wed, 26 Mar 2008 13:52:50 -0300
From: thiagoss <thiagossantos@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <051f01c88e7f$2e73f040$6701a8c0@freqonedev>
MIME-Version: 1.0
References: <051f01c88e7f$2e73f040$6701a8c0@freqonedev>
Subject: Re: [Bluez-devel] Minimum Version of GStreamer for bluez-utils-3.29?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0987921035=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0987921035==
Content-Type: multipart/alternative;
	boundary="----=_Part_16787_30941117.1206550370562"

------=_Part_16787_30941117.1206550370562
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

It was developed using version 0.10.17, but I guess that from
0.10.14everything would work.

Thiago

On Tue, Mar 25, 2008 at 10:50 AM, David Stockwell <
dstockwell@frequency-one.com> wrote:

>  bluez-utils-3.29 does not compile: failing in compilation of
> gstrtpsbcpay.c,
> @201: implicit declaration of gst_adapter_copy, and
> @208: 'GstBaseRtpPayloadClass' has no member named 'handle_event'
>
> It appears GStreamer is only up to 0.10.9 or thereabouts.  What is the
> minimum/expected version of GStreamer 0.10 for bluez-utils-3.29? According
> to the GStreamer site, the current version is 0.10.18, as of just a few
> days ago.
>
> Another question: I do not intend to use streaming audio in this
> application, and I have to ask why all of this is bundled into the audio
> module at this fairly deep layer?  Seems to be a bit too bundled, leading to
> too many dependencies, unless everybody is intent on developing headset
> applications.
>
> DS
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2008.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
>

------=_Part_16787_30941117.1206550370562
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

It was developed using version 0.10.17, but I guess that from 0.10.14 everything would work.<br><br>Thiago<br><br><div class="gmail_quote">On Tue, Mar 25, 2008 at 10:50 AM, David Stockwell &lt;<a href="mailto:dstockwell@frequency-one.com" target="_blank">dstockwell@frequency-one.com</a>&gt; wrote:<br>


<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">





<div bgcolor="#ffffff">
<div><font face="Arial" size="2">bluez-utils-3.29 does not compile: failing in 
compilation of gstrtpsbcpay.c,</font></div>
<div><font face="Arial" size="2">@201: implicit declaration of gst_adapter_copy, 
and</font></div>
<div><font face="Arial" size="2">@208: &#39;GstBaseRtpPayloadClass&#39; has no member named 
&#39;handle_event&#39;</font></div>
<div><font face="Arial" size="2"></font>&nbsp;</div>
<div><font face="Arial" size="2">It appears GStreamer is only up to 0.10.9 or 
thereabouts.&nbsp; What is the minimum/expected version of GStreamer 0.10 for 
bluez-utils-3.29? According to the GStreamer site, the current version is 
0.10.18, as of just a few days ago.</font></div>
<div><font face="Arial" size="2"></font>&nbsp;</div>
<div><font face="Arial" size="2">Another question:&nbsp;I do not intend to use 
streaming audio in this application, and I have to ask why all of this is 
bundled into the audio module at this fairly deep layer?&nbsp; Seems to be a bit 
too bundled, leading to too many dependencies, unless everybody is intent on 
developing headset applications.</font></div>
<div><font face="Arial" size="2"></font>&nbsp;</div><font color="#888888">
<div><font face="Arial" size="2">DS</font></div></font></div>
<br>-------------------------------------------------------------------------<br>
This SF.net email is sponsored by: Microsoft<br>
Defy all challenges. Microsoft(R) Visual Studio 2008.<br>
<a href="http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/" target="_blank">http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/</a><br>_______________________________________________<br>
Bluez-devel mailing list<br>
<a href="mailto:Bluez-devel@lists.sourceforge.net" target="_blank">Bluez-devel@lists.sourceforge.net</a><br>
<a href="https://lists.sourceforge.net/lists/listinfo/bluez-devel" target="_blank">https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br>
<br></blockquote></div><br>

------=_Part_16787_30941117.1206550370562--


--===============0987921035==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
--===============0987921035==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0987921035==--
