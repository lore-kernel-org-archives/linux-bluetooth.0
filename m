Return-Path: <cyrus@holtmann.org>
Date: Thu, 20 Mar 2014 15:06:14 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v6 09/11] tools/mgmt-tester: Refactor
 setup_start_discovery function
Message-ID: <20140320130614.GA11854@t440s.lan>
References: <1395320369-18327-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1395320369-18327-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Thu, Mar 20, 2014, Lukasz Rymanowski wrote:
> This patch removes handling hook register from this
> function and its callback as this is no longer necessary for any stop
> discovery tests.
> 
> This patch also adds setup_send_param and setup_send_len  parameters to
> test data so it is easy to control start discovery command parameters.
> It is useful for tests:
> Stop Discovery - Invalid parameters 1
> Stop Discovery - BR/EDR (Inquiry) Success 1
> ---
>  tools/mgmt-tester.c | 65 ++++++++++++++++-------------------------------------
>  1 file changed, 19 insertions(+), 46 deletions(-)

Applied. Thanks.

Johan
