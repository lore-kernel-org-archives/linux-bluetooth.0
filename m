Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Implements the OBEX server/SyncML client binding for
 syncEvolution (http://syncevolution.org/).
From: Patrick Ohly <patrick.ohly@intel.com>
To: "Zhao, Forrest" <forrest.zhao@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"forrest.zhao@gmail.com" <forrest.zhao@gmail.com>
In-Reply-To: <1256007499-19250-1-git-send-email-forrest.zhao@intel.com>
References: <1256007499-19250-1-git-send-email-forrest.zhao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 20 Oct 2009 09:18:39 +0200
Message-Id: <1256023119.9142.19.camel@pohly-mobl1.ikn.intel.com>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Forrest!

I hope those more familiar with OBEX will comment on those aspects. I
have some questions pertaining to SyncEvolution and the usage of this
new feature.

On Tue, 2009-10-20 at 03:58 +0100, Zhao, Forrest wrote:
[...]
> diff --git a/src/main.c b/src/main.c
> index abd2bcc..36d814f 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -53,6 +53,7 @@
>  #define OPP_CHANNEL    9
>  #define FTP_CHANNEL    10
>  #define PBAP_CHANNEL   15
> +#define SYNCEVOLUTION_CHANNEL  16
>  #define PCSUITE_CHANNEL        24

Do we want to call this "SYNCEVOLUTION" or "SYNCML"? Both has pros and
cons. Treating it as generic SyncML capability hides the detail that
it's currently based on SyncEvolution. Exposing SyncEvolution itself
would allow to activate multiple different SyncML implementations at the
same time.

My preference would be to keep it as is, but I wanted to ask anyway.

Off topic: what is the "PC Suite Services server"?

> +       { "syncevolution", 'e', 0, G_OPTION_ARG_NONE, &option_syncevolution,
> +                               "Enable OBEX server for Syncevolution client" },

Mind the spelling: "syncevolution" (lower case) is the command line
tool, "SyncEvolution" (camel case) the project. "Syncevolution" is a
typo ;-)

Is there documentation that should be updated together with introducing
the new feature?

> +       if (option_syncevolution == TRUE) {
> +               services |= OBEX_SYNCEVOLUTION;
> +               bluetooth_init(OBEX_SYNCEVOLUTION, "OBEX server for"
> +                               " Syncevolution client", NULL,
> +                               SYNCEVOLUTION_CHANNEL, TRUE, FALSE, FALSE,
> +                               NULL);
> +       }
> +

Which string is going to appear in the service description (the SDP
part)? This one here? Mentioning "SyncML" would be useful. So I suggest
"OBEX server for SyncML, using SyncEvolution". Leave out the
"SyncEvolution client", because the term client is a) overloaded
(SyncML/OBEX/D-Bus) and b) SyncEvolution could be both client and server
in this context (SAN => SyncML client, SyncML message => SyncML server).

-- 
Best Regards, Patrick Ohly

The content of this message is my personal opinion only and although
I am an employee of Intel, the statements I make here in no way
represent Intel's position on the issue, nor am I authorized to speak
on behalf of Intel on this matter.


