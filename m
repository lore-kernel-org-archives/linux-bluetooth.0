Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1284980866-3974-4-git-send-email-johan.hedberg@gmail.com>
References: <1284980866-3974-1-git-send-email-johan.hedberg@gmail.com>
	<1284980866-3974-4-git-send-email-johan.hedberg@gmail.com>
Date: Mon, 20 Sep 2010 09:13:13 -0400
Message-ID: <AANLkTi=xM5RSqZJ=bG-PfphpZ8awYKjSY+sB3ey4eu_P@mail.gmail.com>
Subject: Re: [PATCH 3/3] Add hcimgmt command line test tool
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@nokia.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Sep 20, 2010 at 7:07 AM,  <johan.hedberg@gmail.com> wrote:
> +static void usage(void)
> +{
> +       int i;
> +
> +       printf("hcictl - HCI Control ver %s\n", VERSION);

hcictl -> hcimgmt

> +       printf("Usage:\n"
> +               "\thcictl [options] <command> [command parameters]\n");
> +       printf("Options:\n"
> +               "\t--help\tDisplay help\n"
> +               "\t-i dev\tHCI device\n");
> +       printf("Commands:\n");
> +       for (i = 0; command[i].cmd; i++)
> +               printf("\t%-4s\t%s\n", command[i].cmd,
> +               command[i].doc);
> +       printf("\n"
> +               "For more information on the usage of each command use:\n"
> +               "\thcictl <command> --help\n" );
> +}

-- 
Anderson Lizardo
OpenBossa Labs - INdT
Manaus - Brazil
