Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B62E202963
	for <linux-bluetooth@vger.kernel.org>; Sat,  7 Mar 2026 09:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772875985; cv=none; b=TnSDEkvSlaRlG05J2UKwf/YRKS14mOedtBlCF1s8G7L6a7kCJH+8VDxLiGxD2auksF02PLMj7318vPaQ2enbr1h6gR5UBoDxvzZ3QcxTmzVLGxWwc+oU548nggIh9SEprDyp/96EcElSXbQgpPNum+6qeGeLf6pi6aTORqYJ93o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772875985; c=relaxed/simple;
	bh=3b+slrV9gPU0naRIHuMEdeLiIJVhjN/yecNVkF+70G4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=u50IjuyKrGW0yKxNB9qtNlrA/mORamzHdKibTLcCCpX9XJT9pZHmZwl/2mm7kh/hEAElUCoKISbb1lw3ES/aY0chdVODvzgVER8qkyB9kH41/P0YlFZKgWE8M0ukVwhzQ0D0o71DPplHW3OJ56F2Em3EVL9TsfaV9Adir94K9ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-67999892f00so167459462eaf.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 07 Mar 2026 01:33:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772875983; x=1773480783;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2E7MObBONkNTLMAFAYTrYVN1vyKOECJQtBJACa285UI=;
        b=rIjCa5tKz977W0KNog4yZyG+zN5x+1FDAYXSYX7hIzOSn92mKynIXQwobGIZX3qw4p
         TntFnHuxV937URyXHFNqs44xGgPPC09cWOF0ghiAOdwHo5uJuqR8FbilcFBiZKw+lGXG
         aY7iPfBBwdfKGLVHyUeweVGnjvjJz5P057hQPpfBtjh85w4w1QzVQZ4fa/ojQgdsOWEE
         QSuX3j/O6OrIx8xjbeu00Ybnfvu6d76CIewCX9XQPbCXg+Qgx/HUgdZFOZarJVzMQLX1
         CEiFpnHUrwESzJbiJK8xzsYx4Exzsx8SKUmu6aetqSnnWjRIoFrbT0JTQpw6kSBbRUH4
         Mbjw==
X-Gm-Message-State: AOJu0Yz4FE7kPiiZocCCe+BXChgk/qyaDBNfoqkuJgMdfmFdx11rjZxC
	2gXm9GRV1C0ZGrGwEQxroQue9TeyHraaTNTV6QfXCMwWQKlNfaew2+dObE1ZAgerBJ5C2pqV1JH
	zIYuUbFgkr7hW8WcWi3mwQW1+gHOQnDqznNSk14vr892GUwycAlIOL6MaQE4=
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:f023:b0:662:b5e0:e6d1 with SMTP id
 006d021491bc7-67b9bc8144bmr3213084eaf.16.1772875983370; Sat, 07 Mar 2026
 01:33:03 -0800 (PST)
Date: Sat, 07 Mar 2026 01:33:03 -0800
In-Reply-To: <625d3721ef07c7c15488af80fbfc53620921611b.camel@iki.fi>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69abf0cf.050a0220.13f275.0047.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in l2cap_unregister_user
From: syzbot <syzbot+14b6d57fb728e27ce23c@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, pav@iki.fi, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

can't ssh into the instance



failed to run ["ssh" "-p" "22" "-F" "/dev/null" "-o" "UserKnownHostsFile=3D=
/dev/null" "-o" "IdentitiesOnly=3Dyes" "-o" "BatchMode=3Dyes" "-o" "StrictH=
ostKeyChecking=3Dno" "-o" "ConnectTimeout=3D10" "root@10.128.1.205" "pwd"]:=
 exit status 255Pseudo-terminal will not be allocated because stdin is not =
a terminal.
Warning: Permanently added '[us-central1-ssh-serialport.googleapis.com]:960=
0' (ECDSA) to the list of known hosts.
UEFI firmware (version  built at 09:00:00 on Jan 10 2025)
EMU Variable FVB Started
EMU Variable invalid PCD sizes
Found PL031 RTC @ 0x9010000
InitializeRealTimeClock: using default timezone/daylight settings
=1B[2J=1B[01;01H=1B[=3D3h=1B[2J=1B[01;01H=1B[2J=1B[01;01H=1B[=3D3h=1B[2J=1B=
[01;01HBdsDxe: loading Boot0001 "UEFI Misc Device" from PciRoot(0x0)/Pci(0x=
2,0x0)/NVMe(0x1,00-00-00-00-00-00-00-00)
BdsDxe: starting Boot0001 "UEFI Misc Device" from PciRoot(0x0)/Pci(0x2,0x0)=
/NVMe(0x1,00-00-00-00-00-00-00-00)

UEFI: Attempting to start image.
Description: UEFI Misc Device
FilePath: PciRoot(0x0)/Pci(0x2,0x0)/NVMe(0x1,00-00-00-00-00-00-00-00)
OptionNumber: 1.

  Booting `syzkaller'


serialport: Connected to syzkaller.us-central1-a.ci-upstream-gce-arm64-test=
-job-parallel-1 port 1 (session ID: 0999632978e2591e762757af145c8d34989ebc3=
ddb04e2e60c08a78fd4beda56, active connections: 1).


syzkaller build log:
go env (err=3D<nil>)
AR=3D'ar'
CC=3D'gcc'
CGO_CFLAGS=3D'-O2 -g'
CGO_CPPFLAGS=3D''
CGO_CXXFLAGS=3D'-O2 -g'
CGO_ENABLED=3D'1'
CGO_FFLAGS=3D'-O2 -g'
CGO_LDFLAGS=3D'-O2 -g'
CXX=3D'g++'
GCCGO=3D'gccgo'
GO111MODULE=3D'auto'
GOAMD64=3D'v1'
GOARCH=3D'amd64'
GOAUTH=3D'netrc'
GOBIN=3D''
GOCACHE=3D'/syzkaller/.cache/go-build'
GOCACHEPROG=3D''
GODEBUG=3D''
GOENV=3D'/syzkaller/.config/go/env'
GOEXE=3D''
GOEXPERIMENT=3D''
GOFIPS140=3D'off'
GOFLAGS=3D''
GOGCCFLAGS=3D'-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=3D0=
 -ffile-prefix-map=3D/tmp/go-build2562130928=3D/tmp/go-build -gno-record-gc=
c-switches'
GOHOSTARCH=3D'amd64'
GOHOSTOS=3D'linux'
GOINSECURE=3D''
GOMOD=3D'/syzkaller/jobs-2/linux/gopath/src/github.com/google/syzkaller/go.=
mod'
GOMODCACHE=3D'/syzkaller/jobs-2/linux/gopath/pkg/mod'
GONOPROXY=3D''
GONOSUMDB=3D''
GOOS=3D'linux'
GOPATH=3D'/syzkaller/jobs-2/linux/gopath'
GOPRIVATE=3D''
GOPROXY=3D'https://proxy.golang.org,direct'
GOROOT=3D'/usr/local/go'
GOSUMDB=3D'sum.golang.org'
GOTELEMETRY=3D'local'
GOTELEMETRYDIR=3D'/syzkaller/.config/go/telemetry'
GOTMPDIR=3D''
GOTOOLCHAIN=3D'auto'
GOTOOLDIR=3D'/usr/local/go/pkg/tool/linux_amd64'
GOVCS=3D''
GOVERSION=3D'go1.26.0'
GOWORK=3D''
PKG_CONFIG=3D'pkg-config'

git status (err=3D<nil>)
HEAD detached at c06e8995d7
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
go list -f '{{.Stale}}' ./sys/syz-sysgen | grep -q false || go install ./sy=
s/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
bin/syz-sysgen
touch .descriptions
GOOS=3Dlinux GOARCH=3Darm64 go build -ldflags=3D"-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Dc06e8995d711b5a8d8fbd771826fcbfdac6f110f -X g=
ithub.com/google/syzkaller/prog.gitRevisionDate=3D20250811-165554"  -o ./bi=
n/linux_arm64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_arm64
aarch64-linux-gnu-g++ -o ./bin/linux_arm64/syz-executor executor/executor.c=
c \
	-O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wframe-l=
arger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-format-ove=
rflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -stati=
c-pie -std=3Dc++17 -I. -Iexecutor/_include   -DGOOS_linux=3D1 -DGOARCH_arm6=
4=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"c06e8995d711b5a8d8fbd771826fcbfdac=
6f110f\"
/usr/lib/gcc-cross/aarch64-linux-gnu/14/../../../../aarch64-linux-gnu/bin/l=
d: /tmp/ccd7e8uY.o: in function `Connection::Connect(char const*, char cons=
t*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0x2ec): warning: Using 'gethostbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking



Tested on:

commit:         708efc5f Bluetooth: HIDP: Fix possible UAF
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/blu=
etooth-next.git master
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dde187e3c06ea9a2=
b
dashboard link: https://syzkaller.appspot.com/bug?extid=3D14b6d57fb728e27ce=
23c
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-=
1~exp1~20251221153213.50), Debian LLD 21.1.8
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D11b8075a5800=
00

