Return-Path: <cyrus@holtmann.org>
From: "Christian Hoene" <hoene@uni-tuebingen.de>
To: "'Luiz Augusto von Dentz'" <luiz.dentz@gmail.com>
Cc: <linux-bluetooth@vger.kernel.org>
References: <200812301246.25781.siarhei.siamashka@nokia.com>	 <200901051027.57446.siarhei.siamashka@nokia.com>	 <1231155783.9401.1.camel@hoene-desktop>	 <2d5a2c100901050422hcf69bcak8e717356e1f8dbf9@mail.gmail.com>	 <1231158516.9401.3.camel@hoene-desktop> <2d5a2c100901050513t73cbd8a0v924f7d52e0cae271@mail.gmail.com>
In-Reply-To: <2d5a2c100901050513t73cbd8a0v924f7d52e0cae271@mail.gmail.com>
Subject: RE: [PATCH] SBC Encoder program
Date: Mon, 5 Jan 2009 15:42:39 +0100
Message-ID: <002801c96f43$dd2e70b0$978b5210$@de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> Just the codesize is 16 bit, right? So I guess the following changes
> are not really necessary:
> 
> 
> +	uint16_t subbands, channels, blocks;

No, but then we have to change the last line of the function to
  return ((uint16_t)subbands) * blocks * channels * 2;

CH

