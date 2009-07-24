Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1346165.1248430092866.JavaMail.root@safetgram>
References: <1346165.1248430092866.JavaMail.root@safetgram>
Date: Fri, 24 Jul 2009 10:47:52 -0600
Message-ID: <d89ddf300907240947p174ffebaw6300e232bdc3d36f@mail.gmail.com>
Subject: Re: Intermittent "Address already in use" error
From: Brad Midgley <bmidgley@gmail.com>
To: John Freeman <johnf@optimation.com.au>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

John,

> From time to time, I encounter an "Address already in use" error when
> attempting to bind a socket to a particular local adapter.  The python
> code looks like:
>
>   Listener = BluetoothSocket(SCO)
>   Listener.bind((addr1, ))
>   Listener.listen(1)

Is the error appearing when you want to rebind a short time after it
was used? Maybe you need to setsockopt SO_REUSEADDR just like you
would if you wanted to quickly rebind a tcp serversocket.

-- 
Brad Midgley
