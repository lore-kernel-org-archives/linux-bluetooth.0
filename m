Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Laczen JMS <laczenjms@gmail.com>
Date: Fri, 1 Sep 2017 16:34:23 +0200
Message-ID: <CAFxSrVv9LPryt-xEPup-8Pq9eaNjt0J9dqn3+BmbJnBgPQTecw@mail.gmail.com>
Subject: Meshctl - Modification to agent.c for easier entering static OOB key
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Entering a static OOB key in meshctl requires all 16 bytes. With the
following change a shorter
key can be entered. I have never created a patch, so sorry about the format:

In agent.c @ line 102:
static bool response_hexadecimal(const char *input)
{
  uint8_t buf[MAX_HEXADECIMAL_OOB_LEN];

  if (!str2hex(input, strlen(input), buf, pending_request.len) ) {
rl_printf("Incorrect input: expecting %d hex octets\n",
 pending_request.len);
return false;
}
...

changes to:

static bool response_hexadecimal(const char *input)
{
  uint8_t buf[MAX_HEXADECIMAL_OOB_LEN];

  memset(buf, 0, pending_request.len);
  str2hex(input, strlen(input), buf, strlen(input)/2);
...

Kind regards,

Jehudi
