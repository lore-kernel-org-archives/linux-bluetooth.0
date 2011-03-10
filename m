Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v4] Implement ATT handle indications
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=iso-8859-1
From: =?iso-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>
In-Reply-To: <AANLkTimoeb9NAsuN3QS+UP1P2obYhY7rj+D-Ww4G1+QV@mail.gmail.com>
Date: Thu, 10 Mar 2011 11:35:26 -0300
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <33BF64D1-1970-4C0E-9CD8-BD3129230DAF@signove.com>
References: <1299765690-16322-1-git-send-email-epx@signove.com> <AANLkTimoeb9NAsuN3QS+UP1P2obYhY7rj+D-Ww4G1+QV@mail.gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	=?iso-8859-1?Q?Andr=E9_Dieb?= <andre.dieb@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


On 10 Mar 2011, at 11:16 , Claudio Takahasi wrote:

> Hi Elvis,
> 
> Is it allowed to have notification and indication bits set to the same
> characteristic?

Client Characteristic Configuration is a bitmap, and in theory it is possible
for a client to set both bits (configuration and indication), even though it
looks silly to do so. BlueZ currently allows this and I didn't find any
mention in the docs preventing it.

André had mentioned something about mutual exclusion of indicaitons and
notifications some days ago. Do you have anything to add, Andre?