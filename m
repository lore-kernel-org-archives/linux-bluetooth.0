Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] android/sco: Add sco helper lib
Date: Mon, 24 Nov 2014 12:38:17 +0100
Message-ID: <11159516.HObWJUiDMz@uw000953>
In-Reply-To: <1416237398-6376-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1416237398-6376-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Monday 17 of November 2014 16:16:38 Lukasz Rymanowski wrote:
> This patch adds sco lib which gives means to create SCO object with
> API to create listening socket, connect and disconnect.
> 
> This is going to be common code for HFP HF and HFP GW.
> For now we support only one SCO at the time.
> 
> SCO listening socket is created once bt_sco_new() is called, but
> SCO connection is possible only if confirm and connect callbacks are
> registered.
> 
> Sco lib is not aware about voice settings. Those must be provided
> on bt_sco_connect or in confirm callback.
> 
> This patch also adds this lib to Android build.
> ---
> v2:
> * handled almost all Szymon comments
> Not handled comment: Extend register callbacks with destroy and user_data is not
> added. This is because we do not need it and also I'm not sure how it would be used.
> These callbacks are used for both incoming and outgoing connection. And having common
> user data for both probably does not make sense. So I would have to split it somehow
> and this IMHO is overkill.

Applied. Thanks.
 

-- 
Best regards, 
Szymon Janc
