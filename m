Return-Path: <cyrus@holtmann.org>
Date: Fri, 18 Sep 2009 14:18:03 +0100 (BST)
To: Lorenzo Brito Morales <lorenzo.brito@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Help
In-Reply-To: <c1d79cc40909180419t45198d46h91b06ca20383fc12@mail.gmail.com>
References: <c1d79cc40909180419t45198d46h91b06ca20383fc12@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Message-Id: <1253279884.019277.17552.nullmailer@galant.ukfsn.org>
From: Iain Hibbert <plunky@rya-online.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 18 Sep 2009, Lorenzo Brito Morales wrote:

> Hi, im a beggineer in bluez and also in programming stuff, i have read
> a coupble of things about bluez and programming,  what i want to do is
> a progran that send files to the phone is near by,,im trying to get
> work these code, its compile, and conect to the phone , but in the
> phone ask for a number security, ahta later i have to type in the
> computer...... how can i send a file whitout asking a number? just
> asking in the phone about aceptting the file

Well, in this case the phone requires authentication to connect to the
service on RFCOMM channel #1 so you are out of luck unless you can provide
the same PIN at both ends (or other pairing)

You need to investiage "OBEX Object Push". Sometimes you can send a text
file without authentication, but the person who owns the phone will
usually be required to authorise the connection (ie a message will appear,
asking if they wish to receive the file and they will need to approve)

It is a long way to do it yourself, look for "obexd" at www.bluez.org

iain


