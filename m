Return-Path: <cyrus@holtmann.org>
Message-ID: <1336390921.4325.19.camel@jlt3.sipsolutions.net>
Subject: Re: [RFCv2 4/6] mac80211: softamp: Handle assoc request
From: Johannes Berg <johannes@sipsolutions.net>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-wireless@vger.kernel.org
Date: Mon, 07 May 2012 13:42:01 +0200
In-Reply-To: <1335273460-12682-5-git-send-email-Andrei.Emeltchenko.news@gmail.com> (sfid-20120424_151656_805125_63BCA33F)
References: <1335273460-12682-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1335273460-12682-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 (sfid-20120424_151656_805125_63BCA33F)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2012-04-24 at 16:17 +0300, Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Handle AMP assoc request.

This needs knowledge about channel preferences etc. I think it should be
done in wpa_supplicant.

johannes

