Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1511532934.11411.15.camel@hadess.net>
Subject: Re: [PATCH 1/4] build: Always define confdir and statedir
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Date: Fri, 24 Nov 2017 15:15:34 +0100
In-Reply-To: <20170920114819.19929-1-hadess@hadess.net>
References: <20170920114819.19929-1-hadess@hadess.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 2017-09-20 at 13:48 +0200, Bastien Nocera wrote:
> As we will need those paths to lock down on them.

The 4 patches in this patchset are still relevant.

NoNewPrivileges broke SELinux on Fedora, but the problem has since been
fixed in the kernel SELinux support to handle it properly.

Cheers
