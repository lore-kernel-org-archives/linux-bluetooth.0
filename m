Return-Path: <cyrus@holtmann.org>
Date: Thu, 14 Jul 2011 16:38:55 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd v3 0/2] Add handling of system D-Bus method calls
Message-ID: <20110714133855.GC2770@dell.ger.corp.intel.com>
References: <1310550226-9656-1-git-send-email-dmitriy.paliy@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1310550226-9656-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitriy,

On Wed, Jul 13, 2011, Dmitriy Paliy wrote:
> This is updated version where
> client/session.c:189: error: no previous declaration for 'find_session_request'
> make[1]: *** [client/session.o] Error 1
> is fixed.
> 
> Please, check if
> +static struct pending_req *find_session_request(
> +				const struct session_data *session,
> 
> is coding-style-wise acceptable.

That's fine. Both patches have been applied. Thanks.

Johan
