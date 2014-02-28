Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH 4/6] android/socket: Reserve channel for HSP AG
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1848977.f8HFz4UXRu@uw000953>
Date: Fri, 28 Feb 2014 09:19:53 -0800
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Message-Id: <F7302E45-4F3B-4DC7-9C56-ACF7FBF33DD9@holtmann.org>
References: <1393604374-10127-1-git-send-email-szymon.janc@tieto.com> <1393604374-10127-4-git-send-email-szymon.janc@tieto.com> <20140228164459.GA23792@localhost.P-661HNU-F1> <1848977.f8HFz4UXRu@uw000953>
To: Szymon Janc <szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

>>> ---
>>> android/socket.c | 14 ++++++++++++--
>>> 1 file changed, 12 insertions(+), 2 deletions(-)
>>> 
>>> diff --git a/android/socket.c b/android/socket.c
>>> index ee98b54..f6863c8 100644
>>> --- a/android/socket.c
>>> +++ b/android/socket.c
>>> @@ -47,8 +47,9 @@
>>> 
>>> #define RFCOMM_CHANNEL_MAX 30
>>> 
>>> +#define HSP_AG_DEFAULT_CHANNEL	11
>>> #define OPP_DEFAULT_CHANNEL	12
>>> -#define HFAG_DEFAULT_CHANNEL	13
>>> +#define HFP_AG_DEFAULT_CHANNEL	13
>>> #define PBAP_DEFAULT_CHANNEL	19
>> 
>> Wasn't our plan to mirror the BlueZ doc/assigned-numbers.txt here? At
>> least the OPP and HSP channels don't match up with that.
> 
> We followed Bluedroid channels (although for HSP I did check which one is
> used:), but we could go with BlueZ assigned-numbers.txt. That would require
> fixed channels numbers for MAP, but that shouldn't be a problem.

lets go with the Bluedroid ones, but make sure we document it somewhere which ones are used for what. I do not want to have to dig that out of the code.

Regards

Marcel

