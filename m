Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTimXDqAej=LAVDvDgspKuH_SAKivp9eL8R9tXPJc@mail.gmail.com>
References: <AANLkTimXDqAej=LAVDvDgspKuH_SAKivp9eL8R9tXPJc@mail.gmail.com>
Date: Thu, 19 Aug 2010 11:49:52 +0300
Message-ID: <AANLkTi=qrkSSmDNcVNpFm=3=5mSzs9Se08h8JDryDcOu@mail.gmail.com>
Subject: Re: BlueZ's A2DP sink role
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Pavan Savoy <pavan_savoy@sify.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Pavan,

On Wed, Aug 18, 2010 at 11:22 PM, Pavan Savoy <pavan_savoy@sify.com> wrote:
> As I understand, the A2DP sink role is @ audio/source.c and A2DP
> source role is at sink.c ? (or what is called as the interfaces?..)
> Also How do I test out a2dp sink role in BlueZ, any test audio-server
> I can run ?

You can use PA as explained in Joao Paulo's blog:

http://jprvita.wordpress.com/2009/12/15/1-2-3-4-a2dp-stream/


-- 
Luiz Augusto von Dentz
Computer Engineer
