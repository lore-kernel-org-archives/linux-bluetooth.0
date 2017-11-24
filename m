Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1511532391.11411.7.camel@hadess.net>
Subject: Re: [PATCH 1/2] tools/csr_usb: Fix compilation failure
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Date: Fri, 24 Nov 2017 15:06:31 +0100
In-Reply-To: <20171102140953.21684-1-hadess@hadess.net>
References: <20171102140953.21684-1-hadess@hadess.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 2017-11-02 at 15:09 +0100, Bastien Nocera wrote:
> GCC's "format-nonliteral" security check is enabled as an error in
> recent versions of Fedora. Given the limited formats, pass a boolean
> to switch between the 2 different formats.
> 
> tools/csr_usb.c: In function 'read_value':
> tools/csr_usb.c:82:2: error: format not a string literal, argument
> types not checked [-Werror=format-nonliteral]
>   n = fscanf(file, format, &value);
>   ^

This still applies.
