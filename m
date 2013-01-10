Return-Path: <cyrus@holtmann.org>
Date: Thu, 10 Jan 2013 11:47:34 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org,
	Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: Re: [PATCH BlueZ 1/3] build: Do not use deprecated AM_CONFIG_HEADER
Message-ID: <20130110144734.GA25196@samus>
References: <1357262465-19231-1-git-send-email-lucas.demarchi@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1357262465-19231-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On 23:21 Thu 03 Jan, Lucas De Marchi wrote:
> From: Lucas De Marchi <lucas.de.marchi@gmail.com>
> 
> The long-obsoleted AM_CONFIG_HEADER macro was removed in automake 1.13.
> Use AC_CONFIG_HEADERS instead.

I think oFono and neard are still missing this fix. Would you care to
send it?


Cheers,
-- 
Vinicius
