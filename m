Return-Path: <cyrus@holtmann.org>
Date: Wed, 9 Feb 2011 13:26:42 -0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Sheldon Demario <sheldon.demario@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/5] Add an initial interactive mode to gatttool
Message-ID: <20110209212642.GA11368@jh-x301>
References: <1297179136-14750-1-git-send-email-sheldon.demario@openbossa.org>
 <1297179136-14750-3-git-send-email-sheldon.demario@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1297179136-14750-3-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Feb 08, 2011, Sheldon Demario wrote:
> +int do_interactive(void);

I don't really like having an exported function called do_*. The places
I've seen this naming convention have usually been when there's some
other function already with the name you want and in all places the do_
variant is static. How about simply interactive() or interactive_mode().
Also, shouldn't you be passing the minimum config options as parameters
to this function? Otherwise you'll have to have some sort of global
config variables.

> +++ b/attrib/igatttool.c

Since we don't have igattool anymore, how about calling this
interactive.c?

> +static void cmd_help(int argcp, char **argvp);
> +static void cmd_exit(int argcp, char **argvp);

No forward-declarations please. Just reorder the functions so that you
don't need to do this.

Johan
