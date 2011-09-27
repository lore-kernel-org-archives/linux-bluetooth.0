Return-Path: <cyrus@holtmann.org>
Date: Tue, 27 Sep 2011 12:15:58 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Syam Sidhardhan <syamsidhardh@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix crash when update service record with an invalid XML
Message-ID: <20110927091558.GO3952@dell>
References: <1316338155-3862-1-git-send-email-syamsidhardh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1316338155-3862-1-git-send-email-syamsidhardh@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Syam,

On Sun, Sep 18, 2011, Syam Sidhardhan wrote:
> If we pass an invalid xml to sdp_xml_parse_record(), then it returns
> NULL. Further we are passing the this NULL pointer to the
> sdp_record_free(), which leads to invalid memory access.
> ---
>  plugins/service.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)

Applied. Thanks.

Johan
