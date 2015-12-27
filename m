Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: [PATCH] tools: fix update_compids to parse newly formatted page from SIG
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1451251860-12691-1-git-send-email-mikeryan@lacklustre.net>
Date: Sun, 27 Dec 2015 13:59:32 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <B23BC13C-A553-467A-A610-87DEB8A8A6F9@holtmann.org>
References: <1451251860-12691-1-git-send-email-mikeryan@lacklustre.net>
To: Mike Ryan <mikeryan@lacklustre.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ryan,

> This patch adds tools/parse_companies.pl, a twisted Perl script that
> parses the SIG's HTML page in poor taste using regex. Improvements also
> include support for non-ASCII entities such as &eacute; as well as full
> unicode support for Chinese names.
> ---
> tools/parse_companies.pl | 59 ++++++++++++++++++++++++++++++++++++++++++++++++
> tools/update_compids.sh  | 35 ++++++++--------------------
> 2 files changed, 69 insertions(+), 25 deletions(-)
> create mode 100755 tools/parse_companies.pl

patch has been applied.

Regards

Marcel

