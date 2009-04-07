Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Use cups-config instead of hardcoded location
From: Bastien Nocera <hadess@hadess.net>
To: dev-zero@gentoo.org
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1239094799.19235.2.camel@localhost>
References: <1239094799.19235.2.camel@localhost>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Tue, 07 Apr 2009 11:25:48 +0100
Message-Id: <1239099948.20817.15.camel@cookie.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2009-04-07 at 10:59 +0200, Tiziano Müller wrote:
> Hi there
> 
> This patch has been sitting in our cvs repo for ages:
> Use cups-config instead of hardcoded cups-location.

This check should be done in configure.ac, along with a default if
cups-config isn't available. Otherwise we'll end up with stuff
in /backend and warnings during the build.

