Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] tools: escape double quotes in company names
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1470840777-71172-1-git-send-email-mikeryan@lacklustre.net>
Date: Wed, 14 Sep 2016 14:51:33 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <522F803E-679A-4004-B95E-47CF5BD7693E@holtmann.org>
References: <1470840777-71172-1-git-send-email-mikeryan@lacklustre.net>
To: Mike Ryan <mikeryan@lacklustre.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mike,

> Double quotes in company names are properly escaped so that they are
> valid C string literals.
> ---
> tools/parse_companies.pl | 1 +
> 1 file changed, 1 insertion(+)
> 
> diff --git a/tools/parse_companies.pl b/tools/parse_companies.pl
> index f755390..99d3f31 100755
> --- a/tools/parse_companies.pl
> +++ b/tools/parse_companies.pl
> @@ -51,6 +51,7 @@ while (<>) {
>         my $name = uri_decode($1);
>         $name =~ s/^\s+//g; # kill leading
>         $name =~ s/\s+$//g; # and trailing space
> +        $name =~ s/"/\\"/g; # escape double quotes
>         my $id = hex($identifier);
>         if ($id != 65535) {
>             print "\tcase $id:\n";

patch has been applied.

Regards

Marcel

