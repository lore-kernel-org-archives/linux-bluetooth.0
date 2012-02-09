Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <F077852F86D84892A3B10767242C50BC@sisodomain.com>
References: <1328182441-14892-1-git-send-email-jaganath.k@samsung.com>
	<CABBYNZJYyqtD+0c6YYALx8bON3A_S3bXH29K07OFJcq=ZrJCOw@mail.gmail.com>
	<F077852F86D84892A3B10767242C50BC@sisodomain.com>
Date: Thu, 9 Feb 2012 13:07:43 +0200
Message-ID: <CABBYNZLVFFP2v0hXEwrxONGr-t-1i5g6rPxVe_G-wrKM2P=8HQ@mail.gmail.com>
Subject: Re: [PATCH obexd 3/4] irmc: Fix length parameter of strncpy
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Jaganath <jaganath.k@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

On Fri, Feb 3, 2012 at 2:22 PM, Jaganath <jaganath.k@samsung.com> wrote:
> I checked IRMC spec and could not find any length restriction.
> For "sn" spec says "The format of the field is manufacturer dependent."
> and for "manu" and "model" the acceptable value is string.

The patch is not exactly wrong, but I fear that if we really start
reading this information from somewhere, which I guess it is whole
point here, then this fixed length may need some change.

-- 
Luiz Augusto von Dentz
