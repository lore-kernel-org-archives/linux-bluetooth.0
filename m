Return-Path: <cyrus@holtmann.org>
From: =?iso-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>
Content-Type: text/plain; charset=us-ascii
Subject: Question about HDP testing tools submission
Date: Mon, 10 May 2010 12:14:35 -0300
Message-Id: <5B114200-94B9-49EE-A6DC-FD9A0CBF04EA@signove.com>
Cc: epx@signove.com
To: linux-bluetooth@vger.kernel.org
Mime-Version: 1.0 (Apple Message framework v1078)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We have begun development of some testing tools for MCAP and HDP, mostly Python scripts. I already have a HDP record generator/interpreter; more MCAP and HDP things will be ready soon.

The question is: are such tools suitable for submission to BlueZ? Or should we create a repository/project for themselves?

I see a lot of scripts in bluez/test/ folder, but since we are doing things that are quite HDP-specific, I thought it was better to ask first, before submitting a long string of patches...