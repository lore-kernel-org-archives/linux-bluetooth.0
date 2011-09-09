Return-Path: <cyrus@holtmann.org>
Message-ID: <4E5E50B9244041B0A9BE9481D893C2FC@freqoneremote>
From: "David Stockwell" <dstockwell@frequency-one.com>
To: "Lucas De Marchi" <lucas.demarchi@profusion.mobi>
Cc: <linux-bluetooth@vger.kernel.org>
References: <1315524770-12000-1-git-send-email-lucas.demarchi@profusion.mobi> <4B499F5909CB43EAA30894396D6AAD68@freqoneremote> <CAMOw1v4sPndKk6A12phG-HDTX7cuL7w_Z_WGGwkEsvGRL_WNQA@mail.gmail.com>
In-Reply-To: <CAMOw1v4sPndKk6A12phG-HDTX7cuL7w_Z_WGGwkEsvGRL_WNQA@mail.gmail.com>
Subject: Re: [PATCH hcidump] avrcp: fix name of metadata field
Date: Fri, 9 Sep 2011 18:16:27 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

-----Original Message----- 
From: Lucas De Marchi
Sent: Friday, September 09, 2011 8:29 AM
To: David Stockwell
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH hcidump] avrcp: fix name of metadata field

Hi David,

On Fri, Sep 9, 2011 at 9:22 AM, David Stockwell
<dstockwell@frequency-one.com> wrote:
> That's fair.  For what it's worth, would this be better as an enum?

Please, don't top-post.

++++ I realized I did it afterwards, sorry.  I then decided it would be 
wasteful to send yet another e-mail (to you, Johan, the devel list, etc.) 
apologizing.
For most of my e-mail, I am on Windows 7, and I just forgot.

The avrcp parser in hcidump was done entirely with defines... I don't
see any point in changing that.

+++++ At this point, I agree with you, and in fact coded my version the same 
way.  In the Windows/.Net world, they strongly recommend enums because the 
compilers can provide somewhat better error checking.  No matter either way, 
just something to think about.

Lucas De Marchi
--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" 
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html 

