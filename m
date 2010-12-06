Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Mike Tsai <Mike.Tsai@atheros.com>
Subject: Re: [PATCHv4 0/7] Support for out of band association model
Date: Mon, 6 Dec 2010 10:46:09 +0100
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <1290509592-9262-1-git-send-email-szymon.janc@tieto.com> <35B17FE5076C7040809188FBE7913F98406D68CFAB@SC1EXMB-MBCL.global.atheros.com>  <35B17FE5076C7040809188FBE7913F98406D68D125@SC1EXMB-MBCL.global.atheros.com>
In-Reply-To: <35B17FE5076C7040809188FBE7913F98406D68D125@SC1EXMB-MBCL.global.atheros.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201012061046.09668.szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> [Mtsai correction]
> The local OOB data present is set when host send HCI command "Read Local OOB
> Data". And this "OOB data present" flag is sent over the air to peer device
> during pairing.

I think you confused local and remote OOB data.
This flag is about "OOB authentication data from remote device present".
Please see Vol.2 Part E. 7.1.29 "IO Capability Request Reply Command".

-- 
Szymon Janc
on behalf of ST-Ericsson

