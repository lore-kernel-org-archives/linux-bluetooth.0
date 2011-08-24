Return-Path: <cyrus@holtmann.org>
Message-ID: <3E5035FD3C7C4E208317F27CB66E46E3@freqoneremote>
From: "David Stockwell" <dstockwell@frequency-one.com>
To: "Johan Hedberg" <johan.hedberg@gmail.com>
Cc: <linux-bluetooth@vger.kernel.org>
References: <201108232225.08328.dstockwell@frequency-one.com> <20110824083023.GA19274@dell>
In-Reply-To: <20110824083023.GA19274@dell>
Subject: Re: [PATCH 2/3] AVRCP: Metadata item #7 should return TrackDuration
Date: Wed, 24 Aug 2011 07:39:50 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan

-----Original Message----- 
From: Johan Hedberg
Sent: Wednesday, August 24, 2011 3:30 AM
To: David Stockwell
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/3] AVRCP: Metadata item #7 should return TrackDuration

Hi David,

On Tue, Aug 23, 2011, David Stockwell wrote:
> @@ -194,7 +194,8 @@ enum media_info_id {
>  MEDIA_INFO_TRACK = 4,
>  MEDIA_INFO_N_TRACKS = 5,
>  MEDIA_INFO_GENRE = 6,
> - MEDIA_INFO_CURRENT_POSITION = 7,
> + MEDIA_INFO_PLAYING_TIME = 7,
> + MEDIA_INFO_LAST = MEDIA_INFO_PLAYING_TIME,
>  };

Actually that's not quite what I meant. The idea was this:

MEDIA_INFO_PLAYING_TIME = 7,
MEDIA_INFO_LAST,

That way you can just keep adding new entries above MEDIA_INFO_LAST and
its value will always be the last "real" value + 1 (which also means
that the comparison in the for-loop changes from <= to <).

+++++ Thanks.  As you can tell, C is not my most frequently used language...
I'll take care of it and resubmit.

Johan 

