Return-Path: <cyrus@holtmann.org>
Message-ID: <2d5a2c100901050422hcf69bcak8e717356e1f8dbf9@mail.gmail.com>
Date: Mon, 5 Jan 2009 09:22:27 -0300
From: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
To: "Christian Hoene" <hoene@uni-tuebingen.de>
Subject: Re: [PATCH] SBC Encoder program
Cc: "Siarhei Siamashka" <siarhei.siamashka@nokia.com>,
	"Marcel Holtmann" <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <1231155783.9401.1.camel@hoene-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200812301246.25781.siarhei.siamashka@nokia.com>
	 <200901051027.57446.siarhei.siamashka@nokia.com>
	 <1231155783.9401.1.camel@hoene-desktop>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Christian

> Yes, there was a bug in the encoder program. Attached the patch.
>
> Greetings
>  Christian
>
>

Coding style:

return pos > len ? pos : len;


-- 
Luiz Augusto von Dentz
Engenheiro de Computação
