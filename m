Return-Path: <guy@alum.mit.edu>
In-Reply-To: <1067482224.18114.6.camel@pegasus>
References: <1067379074.2419.24.camel@paul> <1067425631.24043.224.camel@pegasus> <D4C83C06-0A45-11D8-B1BA-000A958097E4@alum.mit.edu> <1067482224.18114.6.camel@pegasus>
Mime-Version: 1.0 (Apple Message framework v606)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <FBDCA88C-0A86-11D8-B1BA-000A958097E4@alum.mit.edu>
Cc: Paul Ionescu <paul@acorp.ro>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   ethereal-dev@ethereal.com
From: Guy Harris <guy@alum.mit.edu>
Subject: Re: [Ethereal-dev] Re: [Bluez-devel] bluetooth ethereal dissector
Date: Wed, 29 Oct 2003 19:13:07 -0800
To: Marcel Holtmann <marcel@holtmann.org>
List-ID: <bluez-devel.lists.sourceforge.net>


On Oct 29, 2003, at 6:50 PM, Marcel Holtmann wrote:

> here is my patch that adds a Wiretap module for reading files created
> with "hcidump -w".

Checked in, with wiretap/Makefile.nmake updated to build it, with the 
__attribute((packed))__ stuff removed (not all compilers used to build 
Wiretap support it, and there are no fields in there that would require 
padding), and with the byte swapping done with "g_ntohs()" and 
"g_ntohl()" so it doesn't have to include headers not found on all 
platforms.
