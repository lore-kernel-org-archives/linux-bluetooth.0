Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v5 00/11] shared/hfp: Add support for HFP HF
Date: Tue, 28 Oct 2014 08:20:19 +0100
Message-ID: <2479106.vBuIEmuL25@leonov>
In-Reply-To: <1414151975-20588-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1414151975-20588-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Friday 24 of October 2014 13:59:24 Lukasz Rymanowski wrote:
> Following patches extends hfp API with HFP HF functionality.
> HFP HF parser has been added and unit test for it.
> 
> To consider: how strict we should be when it comes to parsing
> AT responses. For example, at the moment, command +CCLC:<cr><lf>
> will be recognized as +CCLC: eventhough correct response format
> should be <cr><lf>+CCLC:<cr><lf>
> 
> Note: As discussed on IRC I did not try to generalize code.
> 
> v2:
> * minor self review fixes
> * response callback on send command, contains now result (OK/ERROR) and
> data from unsolicited response if available.
> 
> v3:
> * Fix some memory leaks found on self review
> 
> v4:
> * Fallback to approach from v1 in context of response callback for AT
> command. Bassically, if AT+X has +X and OK response, response callback
> contains only OK or ERROR code (including CME which will be added in
> following patches). To get +X response, user need to use hfp_hf_register()
> API. It is done mostly to keep hfp.c simple. With this approach we do not
> have to cache all +X in hfp.c before calling response callback.
> 
> v5:
> * Szymon comments taken into account
> * Support to handle wrapped commands in ringbuffer. Note that for testing I
> used modified buffer size in hfp but eventually unit test will be done for
> that.
> 
> Lukasz Rymanowski (11):
>   shared/hfp: Add support for HFP HF
>   shared/hfp: Add set_debug and close_on_unref API for HFP HF
>   shared/hfp: Add set disconnect handler and disconnect API to HFP HF
>   shared/hfp: Add register/unregister event for HFP HF
>   shared/hfp: Add HFP HF parser
>   shared/hfp: Add send AT command API for HFP HF
>   unit/test-hfp: Provide test_handler function via struct data
>   unit/test-hfp: Add init test for HFP HF
>   unit/test-hfp: Add send command tests for HFP HF
>   unit/test-hfp: Add tests for unsolicited results for HFP HF
>   unit/test-hfp: Add some robustness tests for HFP HF
> 
>  src/shared/hfp.c | 649
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++ src/shared/hfp.h | 
> 30 +++
>  unit/test-hfp.c  | 283 ++++++++++++++++++++++--
>  3 files changed, 943 insertions(+), 19 deletions(-)

All patches are now applied, thanks.

-- 
BR
Szymon Janc
