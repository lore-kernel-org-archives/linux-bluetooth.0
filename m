Return-Path: <cyrus@holtmann.org>
Date: Mon, 14 Nov 2011 16:17:52 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd] phonebook-tracker: Seek for contact name deeper
Message-ID: <20111114141752.GA3457@fusion.localdomain>
References: <1321277454-25486-1-git-send-email-lkslawek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1321277454-25486-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Slawek,

On Mon, Nov 14, 2011, Slawomir Bochenski wrote:
> +	if (reply[COL_FAMILY_NAME][0] == 0 &&
> +			reply[COL_GIVEN_NAME][0] == 0 &&
> +			reply[COL_ADDITIONAL_NAME][0] == 0 &&
> +			reply[COL_NAME_PREFIX][0] == 0 &&
> +			reply[COL_NAME_SUFFIX][0] == 0) {
> +		if (reply[COL_FULL_NAME][0] != 0)

0 is for integers. '\0' is for characters. NULL is for pointers. They
may be the same thing in the resulting object code but for better
readability (directly seeing the type of the variable in question)
please make the distinction in the source code.

Johan
