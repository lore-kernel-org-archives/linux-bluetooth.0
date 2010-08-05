Return-Path: <cyrus@holtmann.org>
Message-ID: <4C5B0884.2040805@aircable.net>
Date: Thu, 05 Aug 2010 15:52:52 -0300
From: Manuel Naranjo <manuel@aircable.net>
MIME-Version: 1.0
To: BlueZ <linux-bluetooth@vger.kernel.org>
Subject: NoInputNoOutput and legacy pairing?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi guys,

I have a question regarding the NoInputNoOutput mode for registering 
agents for BlueZ. What happens when there's a legacy pin request and the 
mode is NoInputNoOutput? Will it fallback to standard pin code pairing?

My system is working in an environment where no screen or no keyboard is 
available so I can't pair with a random number. Thing is in some cases I 
still need to fallback to a hardcoded pin because some cellphones 
require it.

Manuel
