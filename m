Return-Path: <cyrus@holtmann.org>
Date: Thu, 10 Feb 2011 09:23:48 -0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Sheldon Demario <sheldon.demario@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/5] Add an initial interactive mode to gatttool
Message-ID: <20110210172348.GA1925@jh-x301>
References: <1297179136-14750-1-git-send-email-sheldon.demario@openbossa.org>
 <1297179136-14750-3-git-send-email-sheldon.demario@openbossa.org>
 <20110209212642.GA11368@jh-x301>
 <AANLkTin=2-k7F7DUO8rvzLJgf-m7+wUQ7FgtUR5ivuMu@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTin=2-k7F7DUO8rvzLJgf-m7+wUQ7FgtUR5ivuMu@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sheldon,

On Thu, Feb 10, 2011, Sheldon Demario wrote:
> >> +static void cmd_help(int argcp, char **argvp);
> >> +static void cmd_exit(int argcp, char **argvp);
> >
> > No forward-declarations please. Just reorder the functions so that you
> > don't need to do this.
> 
> The problem is the cmd_help() function. It must be declared to be
> known by commands[] array.
> The commands[] array also must be known by cmd_help(), so what do you
> suggest to solve this?

For that one a forward-declaration is fine.

Johan
