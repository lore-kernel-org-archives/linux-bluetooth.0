Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH 0/2] Message Access Profile, cont.
Date: Wed, 23 Mar 2011 14:56:18 +0100
Message-Id: <1300888580-19317-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As Johan insisted, here is another approach.

Functions used for accessing message storage are going to be a bit more
independent from MAP architecture and so more reusable in other places.

There may be some initialization needed before storage is usable. This is
introduced in first patch. I was thinking about other ways to do it:

1) Add OBEX_PLUGIN_DEFINE to messages-*.c and so make it a plugin (this
is related to what Luiz suggested before).

This would however prevent MAP plugin from being able to refuse to load
if message storage is not functional. Also it breaks the idea of message
storage API being independent from obexd architecture.

2) Add reference counter of plugin users, so only last messages_exit
would free common resources (like it is the case with root_folder in
messages_dummy.c).

This would get harder is someone would wish to use threads at some point.

3) Get rid of static data and return pointer from messages_init() that
would be passed to all message storage functions calls.

This option still may need some reference counting and data shared
between API clients at some point (I'm thinking about implementation of
undelete behaviour, required by MAP, when actual storage does not have
that possibility).


What do you think?
