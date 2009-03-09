Return-Path: <cyrus@holtmann.org>
Subject: Re: Broken SDP parsing?
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <2d5a2c100903090940m4aa3b7bbj5c0528ea1b175d5e@mail.gmail.com>
References: <1236301226.3602.2314.camel@cookie.hadess.net>
	 <1236523586.16880.141.camel@cookie.hadess.net>
	 <2d5a2c100903090608kd4ffea6sd9b1746e2362bf2@mail.gmail.com>
	 <1236608040.16880.1580.camel@cookie.hadess.net>
	 <2d5a2c100903090732x6d677dccp747c469b43906f71@mail.gmail.com>
	 <1236612318.16880.1656.camel@cookie.hadess.net>
	 <2d5a2c100903090940m4aa3b7bbj5c0528ea1b175d5e@mail.gmail.com>
Content-Type: multipart/mixed; boundary="=-f/rxrBWtsQopx8Msvxma"
Date: Mon, 09 Mar 2009 17:09:39 +0000
Message-Id: <1236618579.32264.23.camel@cookie.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-f/rxrBWtsQopx8Msvxma
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2009-03-09 at 13:40 -0300, Luiz Augusto von Dentz wrote:
> Hi Bastien,
> 
> On Mon, Mar 9, 2009 at 12:25 PM, Bastien Nocera <hadess@hadess.net> wrote:
> > On Mon, 2009-03-09 at 11:32 -0300, Luiz Augusto von Dentz wrote:
> > Problem was sdp_data_alloc() falling back to doing an strlen() on the
> > string, instead of taking its existing length into account. That would
> > break any strings with NULLs embedded.
> >
> > The attached patch fixes this. I'm not certain that making this public
> > is useful, but feel free to make it so if you feel it's needed.
> >
> > Cheers
> >
> 
> Sounds good to me, I will check with Marcel or Johan if they can get
> this changes upstream.

Apparently &#00; isn't an allowed character in XML, so the attached
patch just swaps it out for a space. Much easier.

Cheers

--=-f/rxrBWtsQopx8Msvxma
Content-Disposition: attachment; filename="bluez-sdp-xml-with-nulls-2.patch"
Content-Type: text/x-patch; name="bluez-sdp-xml-with-nulls-2.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

diff --git a/common/sdp-xml.c b/common/sdp-xml.c
index 0403dcd..c3d3934 100644
--- a/common/sdp-xml.c
+++ b/common/sdp-xml.c
@@ -239,9 +239,7 @@ static void convert_raw_data_to_xml(sdp_data_t *value, int indent_level,
 		hex = 0;
 
 		for (i = 0; i < length; i++) {
-			if (value->val.str[i] == '\0')
-				break;
-			if (!isprint(value->val.str[i])) {
+			if (!isprint(value->val.str[i]) && value->val.str[i] != '\0') {
 				hex = 1;
 				break;
 			}
@@ -304,7 +302,9 @@ static void convert_raw_data_to_xml(sdp_data_t *value, int indent_level,
 					strBuf[j++] = 'o';
 					strBuf[j++] = 't';
 				}
-				else {
+				else if (value->val.str[i] == '\0') {
+					strBuf[j++] = ' ';
+				} else {
 					strBuf[j++] = value->val.str[i];
 				}
 			}

--=-f/rxrBWtsQopx8Msvxma--

