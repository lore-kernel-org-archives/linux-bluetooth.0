Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/1] Makes extract_svclass_uuid function public
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=iso-8859-1
From: =?iso-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>
In-Reply-To: <20100513145202.GA4699@jh-x301>
Date: Thu, 13 May 2010 12:00:32 -0300
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <015B428B-7A76-4760-AF3A-4CE581684492@signove.com>
References: <1273757940-11045-1-git-send-email-epx@signove.com> <20100513145202.GA4699@jh-x301>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I am working in SDP record parsing for HDP plug-in and needed this one (option is of course implement a static function that does the same).

I will prefix that and resubmit.

On 13/05/2010, at 11:52, Johan Hedberg wrote:

> Hi,
> 
> On Thu, May 13, 2010, Elvis Pfützenreuter wrote:
>> This patch makes the extract_svclass_uuid function public,
>> so it may be used by applications that link to libbluetooth.
> 
> If it's public it needs to be prefixed with sdp_. What's the usecase
> where you need this?
> 
> Johan

