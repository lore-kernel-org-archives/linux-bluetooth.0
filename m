Return-Path: <cyrus@holtmann.org>
Date: Fri, 21 Sep 2012 16:45:37 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	Rafal Garbat <rafal.garbat@tieto.com>
Subject: Re: [PATCH v6 11/13] heartrate: Add GetProperties method
Message-ID: <20120921134537.GD16944@x220>
References: <1348139690-26985-1-git-send-email-andrzej.kaczmarek@tieto.com>
 <1348139690-26985-12-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1348139690-26985-12-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Thu, Sep 20, 2012, Andrzej Kaczmarek wrote:
> +static const char * const location_enum[] = {
> +	"Other",
> +	"Chest",
> +	"Wrist",
> +	"Finger",
> +	"Hand",
> +	"Earlobe",
> +	"Foot"
> +};

Please add a "," to the end of the last entry to make patches that add
new entries look nicer (they don't have to first remove the last line
and then add two new lines).

Also, is the "const * const" stuff really needed? I think in most places
in the code base with tables like this we've just left out the second
one.

Johan
