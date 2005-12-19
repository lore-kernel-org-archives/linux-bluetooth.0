Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Ville Tervo <ville.tervo@nokia.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] a2dp on maemo/nokia770
Message-ID: <20051219134257.GJ20677@null.research.nokia.com>
References: <43A18AB3.2090507@xmission.com> <20051216130359.GD20677@null.research.nokia.com> <1134743177.4239.29.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1134743177.4239.29.camel@localhost>
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
Date: Mon, 19 Dec 2005 15:42:57 +0200

On Fri, Dec 16, 2005 at 03:26:17PM +0100, ext Marcel Holtmann wrote:
> Hi Ville,
> 
> > > I would like to get A2DP audio working with the 770. The codec would
> > > perform faster/better if it was a proper dsp task but that's beyond the
> > > scope of a volunteer effort.
> > > 
> > > Is nokia working on it?
> > 
> > Currently we are working on basic hs support. A2DP is not yet under
> > focus. However dsp-style approach is one of the possibilities.
> > 
> > Feel free to send any wishes, suggestion and ideas regarding bt audio
> > support. We'll keep them in mind when we do decisions and plans.
> 
> since I've already seen Nokia phones with A2DP Source capabilities, the
> question is now is this a bought solution or is developed inside Nokia.
> If it is developed inside Nokia you might wanna share it or help us out
> to get our SBC in shape and really good and fast.
> 

I wouldn't hold my breath to see that happening. Whan is the situation
with current SBC? What is missing? Is performance optimal? I have
followed discussions about it and there seems to be fixed point
implementaion allready but that has poor quality compared to floating
point version. 


> The Nokia 770 is using a TI chip and basically nobody of us has real
> experiences with these chips. I have seen them in an iPAQ and now the
> 770, but that's it. Do you think Nokia is willing to donate some of the
> TI development kits to BlueZ? Especially the SCO and eSCO stuff needs a
> lot of testing and I would prefer to do it with an i386 or x86_86 based
> system.

I'll try to arrange something.

-- 
Ville


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
