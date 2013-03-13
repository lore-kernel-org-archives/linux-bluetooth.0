Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1361229298.1583.48.camel@aeonflux>
References: <1359986188-24432-1-git-send-email-frederic.dalleau@linux.intel.com>
	<1359986188-24432-2-git-send-email-frederic.dalleau@linux.intel.com>
	<1361229298.1583.48.camel@aeonflux>
Date: Wed, 13 Mar 2013 14:24:09 +0100
Message-ID: <CA+QXtDtu-fCY9JXueApOEzfyB8NZF87Xbnh5T_RYBPrNSNRavw@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] Bluetooth: Add option for SCO socket mode
From: "Dalleau, Frederic" <frederic.dalleau@intel.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: =?ISO-8859-1?Q?Fr=E9d=E9ric_Dalleau?= <frederic.dalleau@linux.intel.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Marcel,

> So I would actually propose to add a voice settings uint16 value as SCO
> socket field. Using the full voice settings make sense since then we can
> also retrieve the fact if we are doing 8-bit or 16-bit PCM. One detail
> we kinda ignored since we always defaulted to 16-bit, but would be worth
> while fixing while at it.

 I'm unconvinced about this. This mean the application wil be able to mess into
what voice settings will be supported. And if csa2 has to be supported
in the future,
a new socket option will be required.
Is 8-bit sco support really worth it ?

Regards,
Fred
