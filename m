Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <9E5B44E9-A8D4-49AB-9D2E-0465BF74ACA1@gmail.com>
References: <1A8743E5-65EA-4625-82FD-658C9722629F@gmail.com>
	<20110215135245.GA11561@jh-x301>
	<1ADFED1F-912D-4DF9-A3BB-795F9AB1D1F8@gmail.com>
	<20110216133411.GD14085@joana>
	<5C042A85-6D54-451D-8BAC-CE24D61907CA@gmail.com>
	<20110216193504.GH14085@joana>
	<9E5B44E9-A8D4-49AB-9D2E-0465BF74ACA1@gmail.com>
Date: Fri, 18 Feb 2011 11:09:00 -0800
Message-ID: <AANLkTimaJJp4PH6kWWNM8znnbhnGWU1d4WbkyxeJWs5q@mail.gmail.com>
Subject: Re: bluetooth disabled with current 2.6.38-rc4
From: Justin Mattock <justinmattock@gmail.com>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

well.. I've looked at this issue a little bit more, and am noticing
that the hci0 device is not being brought up when the daemon is being
called.(udev seems to not being loading for me at boot) Im going to
look and check my configurations to make sure everything is correct.

Justin P. Mattock
