Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Add 'Protocol not supported' error in a2dp_add_sep
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
In-Reply-To: <1300276872-20149-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1300276872-20149-1-git-send-email-dmitriy.paliy@nokia.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 17 Mar 2011 09:45:49 +0200
Message-ID: <1300347949.2509.11.camel@dp-x301>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, 2011-03-16 at 14:01 +0200, ext Dmitriy Paliy wrote:
> 'Protocol not supported' error code is added to registeration of A2DP
> end-points. Error response org.bluez.Error.NotSupported instead of
> org.bluez.Error.InvalidArguments is used when SEP registration fails
> due to disabled corresponding interface in audio.conf.

Seems like there were some comment about this patch that I missed. Could
anybody post a reply with them to this email?

Thanks,
Dmitriy


