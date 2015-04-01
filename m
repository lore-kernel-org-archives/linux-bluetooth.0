Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 1 Apr 2015 18:40:52 +0530
Message-ID: <CAKafyqoaN+fQBH5hjqv6_+ZMt6_b7hGfF_2a6mKAngLF+PR_0w@mail.gmail.com>
Subject: android/handsfree.c | Possible Fix | Review
From: Prabhu Chawandi <foss.chaws@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

  When we were testing handsfree we were seeing command is not being
identified and when looked size was  sent zero when we set it as below
it started working.

static const struct ipc_handler sco_handlers[] = {
        /* SCO_OP_GET_FD */
-        { bt_sco_get_fd, false, 0 }
};


static const struct ipc_handler sco_handlers[] = {
        /* SCO_OP_GET_FD */
 +       { bt_sco_get_fd, false, sizeof(struct sco_cmd_get_fd) }
};

one request -  have you documented anywhere the sequence of commands
to test each profiles supported till now. if we get the the proper
sequences we can validate much faster stabilising the code. Else we
need to spend time in identifying the sequences.

So, if you have documented anywhere request you to share,

ManyThanks,
Prabhu
